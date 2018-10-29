package com.jtgl.draw.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jtgl.draw.constants.StatusConstants;
import com.jtgl.draw.mapper.DrawMapper;
import com.jtgl.draw.model.Draw;
import com.jtgl.draw.model.DrawFrequency;
import com.jtgl.draw.model.DrawPrize;
import com.jtgl.draw.model.DrawProbability;
import com.jtgl.draw.model.DrawResult;
import com.platform.common.exception.CommonException;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.user.model.SysUser;
import com.platform.utils.UserUtils;

@Service
public class DrawService extends BaseService<DrawMapper, Draw> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Autowired
	private DrawFrequencyService drawFrequencyService;
	
	@Autowired
	private DrawPrizeService drawPrizeService;
	
	@Autowired
	private DrawResultService drawResultService;
	
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<Draw> selectByPage(Draw vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<Draw> results = this.selectByProperties(vo);

		PageModel<Draw> page = new PageModel<Draw>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 查询有效的抽奖信息
	 */
	public Draw selectOne(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return super.mapper.selectOne(sdf.format(new Date()));
	}
	
	/**
	 * 用户抽奖
	 */
	@Transactional(readOnly = false)
	public String luckDraw() throws CommonException{
		//当前有效的抽奖信息
		Draw draw = this.selectOne();
		if(draw == null){
			//无效的抽奖(该活动或已下线)
			throw new CommonException(StatusConstants.DRAW_XX_INVALID,StatusConstants.DRAW_XX_INVALID_MSG);
		}
		SysUser user = UserUtils.getUser();
		//根据抽奖基础信息Id和客户ID查询抽奖次数
		int remainNumber = this.checkSurplusFrequency(draw.getId(), user.getId());
		//抽奖次数充足
		if(remainNumber <= 0){
			//抽奖次数不足
			throw new CommonException(StatusConstants.DRAW_CSBZ_INVALID,StatusConstants.DRAW_CSBZ_INVALID_MSG);
		}
		//更新抽奖次数表   抽奖次数-1   (不管我抽没抽到奖,次数都应该-1)
		DrawFrequency drawFrequency = new DrawFrequency();
		drawFrequency.setUserId(user.getId());
		drawFrequency.setDrawId(draw.getId());
		drawFrequency.setUpdateDate(new Date());
		int count = drawFrequencyService.updateLuckyDraw(drawFrequency);
		if(count <= 0){//说明更新的数据为0
			throw new CommonException(StatusConstants.DRAW_CSBZ_INVALID,StatusConstants.DRAW_CSBZ_INVALID_MSG);
		}
		//用户获得的奖项ID
		Integer prizeId = prizeWinners(draw);
		if(prizeId.intValue() == -1){// -1未中奖
			//保存抽奖结果
			DrawResult drawResult = new DrawResult();
			drawResult.setUserId(user.getId());
			drawResult.setDrawId(draw.getId());
			drawResult.setDrawResult(StatusConstants.TDRAW_WZJ_INVALID_MSG);
			drawResultService.save(drawResult);
			return "-1";
		}
		//获取奖项
		DrawPrize drawPrize = drawPrizeService.selectById(prizeId);
		//该奖项剩余抽奖次数-1
		drawPrizeService.updateDrawPrize(drawPrize);
		//保存抽奖结果
		DrawResult drawResult = new DrawResult();
		drawResult.setUserId(user.getId());
		drawResult.setDrawId(draw.getId());
		drawResult.setDrawResult(drawPrize.getPrizeName());
		drawResult.setGroupId(drawPrize.getGroupId());
		drawResultService.save(drawResult);
		//开始 发放赠品券
		if (drawPrize.getGroupId() != null) {
			//根据分组获得产品
			//List<Item> items = itemService.listItem(drawPrize.getGroupId());
			/*if (items != null && !items.isEmpty()) {
				//循环发送奖品
				mapMessage.put("code", 1);
				mapMessage.put("info", drawPrize.getPrizeName());//返回抽奖结果
			}else{
				//该奖项没有产品没有
				throw new RuntimeException("该奖项没有配置奖品,请联系管理员!");
			}*/
		}else{
			//该奖项没有奖品分组
			throw new CommonException(StatusConstants.TDRAW_GROUP_INVALID,StatusConstants.TDRAW_GROUP_INVALID_MSG);
		}
		//返回抽奖结果
		return drawPrize.getPrizeName();
	}
	
	/**
	 * 用户获得的奖项
	 * @param draw 抽奖基础信息
	 * @return
	 */
	public Integer prizeWinners(Draw draw){
		//抽奖概率区间集合
		List<DrawProbability> listDrawProbability = new ArrayList<DrawProbability>();
		int probability = 0;
		//根据抽奖基础信息ID查询 剩余中奖次数>0 所有奖项信息
		List<DrawPrize> listDrawPrize = drawPrizeService.queryDrawPrizeList(draw.getId());
		for (DrawPrize drawPrize : listDrawPrize) {
			DrawProbability drawProbability = new DrawProbability();
			drawProbability.setMinElement(probability);//最小区间值
			probability += drawPrize.getProbability();
			drawProbability.setMaxElement(probability);//最大区间值
			drawProbability.setPrizeId(drawPrize.getId());//奖项ID
			listDrawProbability.add(drawProbability);
		}
		Random rd = new Random();
		int result = rd.nextInt(100+1);
		if("odds_ratio".equalsIgnoreCase(draw.getDrawRatio())){//抽奖比例为 千分比
			result = rd.nextInt(1000+1);
		}
		for (int i = 0; i < listDrawProbability.size(); i++) {	
			DrawProbability drawProbability = listDrawProbability.get(i);
			boolean bool = drawProbability.isContainKey(result);
			if(bool){
				//中奖了
				return drawProbability.getPrizeId();//返回奖项ID
			}
		}
		return -1;//未中奖
	}

	/**
	 * 检查客户的抽奖剩余次数  
	 * @param drawId 抽奖基础信息Id
	 * @param userId 用户ID
	 * @return
	 */
	public int checkSurplusFrequency(Integer drawId, Integer userId){
		
		DrawFrequency drawFrequency = drawFrequencyService.queryDrawFrequency(drawId, userId);
		//抽奖次数充足
		if(drawFrequency != null && drawFrequency.getRemainNumber() > 0){
			return drawFrequency.getRemainNumber();
		}
		return 0;
	}
	
}
