package com.platform.system.lov.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.common.constants.CommonConstants;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.log.service.SysLogService;
import com.platform.system.lov.mapper.SysLovMapper;
import com.platform.system.lov.model.SysLov;
import com.platform.system.lov.model.SysLovLine;

@Service
public class SysLovService extends BaseService<SysLovMapper,SysLov>{

	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private SysLogService logService;
	
    @Autowired
    private EhCacheManager ehCacheManager;
	
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysLov> selectByPage(SysLov vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysLov> results = this.selectByProperties(vo);

		PageModel<SysLov> page = new PageModel<SysLov>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}

	public SysLov selectByCode(String code){
		return this.getMapper().selectByCode(code);
	}

    @Transactional(readOnly = true)
    public List<SysLov> selectFetchLineByProperties(SysLov sysLov) {
        return this.getMapper().selectFetchLineByProperties(sysLov);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	@Transactional(readOnly = true)
    public Map<String,List<Map<String,Object>>> findGlobal(SysLov searchVo) {
        List<SysLov> list = this.selectFetchLineByProperties(searchVo);
        Map<String,List<Map<String,Object>>> lovMap = new HashMap<String,List<Map<String,Object>>>();
        for(SysLov sysLov:list) {
            List<Map<String,Object>> lineList = new ArrayList<Map<String,Object>>();
            for(SysLovLine sysLovLine:sysLov.getLovLineList()) {
                Map<String,Object> lineMap = new HashMap<String,Object>();
                //id作为冗余，以适应前端取值,注意这里是long
                String code = sysLovLine.getCode();
                if(code.matches("^[0-9]*$")) {
                    lineMap.put("id",Long.parseLong(code));
                }
                else {
                    lineMap.put("id",code);
                }
                lineMap.put("code",code);
                lineMap.put("name",sysLovLine.getName());
                lineMap.put("value",sysLovLine.getValue());
                lineMap.put("sort",sysLovLine.getSort());
                lineList.add(lineMap);
            }
            lovMap.put(sysLov.getCode(),lineList);
        }

        Cache cache = ehCacheManager.getCache(CommonConstants.LOV_CACHE_NAME);
        cache.put(CommonConstants.LOV_CACHE_NAME, lovMap);
        return lovMap;
    }
	
    public void saveLov(SysLov sysLov) {
    	logService.log("LOV", "INFO", this.getClass().toString(), JSON.toJSONString(sysLov));
        this.save(sysLov);
    }

    public void updateLov(SysLov sysLov) {
        this.updateNotNull(sysLov);
        //刷新cache
        this.findGlobal(new SysLov());
    }

}
