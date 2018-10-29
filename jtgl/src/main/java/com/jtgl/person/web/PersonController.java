package com.jtgl.person.web;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jtgl.demo.model.FileMeta;
import com.jtgl.person.model.Person;
import com.jtgl.person.service.PersonService;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.system.sequence.service.SysSequenceService;
import com.platform.utils.LocationUtil;
import com.platform.utils.LunarCalendar;

@Controller
@RequestMapping("/api/v1/person")
public class PersonController extends BaseController {
	
	@Autowired
	private PersonService personService;

	@Autowired
	private SysSequenceService sequenceService;
	
	@Value("${uploadPath}")
    private String uploadPath;

    // 根据属性分页查询数据
	@RequiresPermissions("family:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Person person, Model model) throws Exception {
		if(null != person.getParentId()){
			String ids = personService.recursionQueryChild(person.getParentId()+"", person.getParentId()+"");
			person.setIds(ids);
			person.setParentId(null);
		}
		PageModel<Person> page = personService.selectByPage(person);
		model.addAttribute("page", page);
		model.addAttribute("person", person);
		return "jtgl/person/list";
	}

	// 根据属性查询所有数据，不分页
	@RequiresPermissions("family:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<Person>> findAll(Person searchVo) throws Exception {
		return new ResultBuilder<List<Person>>().data(personService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("family:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Person person = new Person();
		if(id != null && id != 0){
			person = personService.selectById(id);
		}
		//上级人员
		Person p = new Person();
		p.setId(id);
		List<Person> listPerson = personService.selectByProperties(p);
		model.addAttribute("person", person);
		model.addAttribute("listPerson", listPerson);
		return "jtgl/person/save";
	}

	// 唯一性校验
    @RequiresPermissions("family:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(Person searchVo) {
        List<Person> list = personService.selectByUnique(searchVo);
        if(list!=null && list.size() > 0) {
            for(Person person:list) {
                if(searchVo.getId() == null||person.getId().longValue() != searchVo.getId().longValue()) {
                    return false;
                }
            }
        }
        return true;
    }
    
	// 保存数据
	@RequiresPermissions("family:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(Person person, Model model) {
		//人员编号
		if(StringUtils.isBlank(person.getNumber())){
			person.setNumber(sequenceService.getCode("person"));
		}
		if (StringUtils.isBlank(person.getMapX()) || StringUtils.isBlank(person.getMapY())) {
			if (StringUtils.isNotBlank(person.getProvince()) && StringUtils.isNotBlank(person.getCity()) && 
					StringUtils.isNotBlank(person.getCounty()) && StringUtils.isNotBlank(person.getAddress())) {
				//解析地址坐标
				String address = person.getProvince() + person.getCity() + person.getCounty() + person.getAddress();
				Map<String, String> map = LocationUtil.getLatitude(address, person.getCity());
				if (map != null) {
					person.setMapX(map.get("lng"));
					person.setMapY(map.get("lat"));
				}
			}
		}
		//根据人员生日获得生肖
		Calendar today = Calendar.getInstance();
        today.setTime(person.getBirthday());
        LunarCalendar lunar = new LunarCalendar();
        lunar.setYear(today.get(Calendar.YEAR));
        person.setZodiac(lunar.animalsYear());//生肖
		personService.save(person);
		return "redirect:/api/v1/person";
	}
	
	// 更新数据
	@RequiresPermissions("family:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Person person, Model model) {
		//人员编号
		if(StringUtils.isBlank(person.getNumber())){
			person.setNumber(sequenceService.getCode("person"));
		}
		if (StringUtils.isBlank(person.getMapX()) || StringUtils.isBlank(person.getMapY())) {
			if (StringUtils.isNotBlank(person.getProvince()) && StringUtils.isNotBlank(person.getCity()) && 
					StringUtils.isNotBlank(person.getCounty()) && StringUtils.isNotBlank(person.getAddress())) {
				//解析地址坐标
				String address = person.getProvince() + person.getCity() + person.getCounty() + person.getAddress();
				Map<String, String> map = LocationUtil.getLatitude(address, person.getCity());
				if (map != null) {
					person.setMapX(map.get("lng"));
					person.setMapY(map.get("lat"));
				}
			}
		}
		//根据人员生日获得生肖
		Calendar today = Calendar.getInstance();
        today.setTime(person.getBirthday());
        LunarCalendar lunar = new LunarCalendar();
        lunar.setYear(today.get(Calendar.YEAR));
        person.setZodiac(lunar.animalsYear());//生肖
		personService.updateNotNull(person);
		return "redirect:/api/v1/person";
	}
	
	// 删除数据
	@RequiresPermissions("family:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		personService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("family:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Person person) {
        String ids = person.getIds();
        for(String id : ids.split(",")) {
            personService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody 
    public Result<List<FileMeta>> upload(MultipartHttpServletRequest request) {
        List<FileMeta> files = new LinkedList<FileMeta>();
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;

        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            FileMeta fileMeta = new FileMeta();
            fileMeta.setName(mpf.getOriginalFilename());
            fileMeta.setSize(mpf.getSize() / 1024 + " Kb");
            fileMeta.setType(mpf.getContentType());

            try {
                fileMeta.setBytes(mpf.getBytes());
                File folder = new File(uploadPath + "personImg/");
                if (!folder.exists()) {
                    folder.mkdirs();
                }
                String location = uploadPath + "personImg/" + mpf.getOriginalFilename();
                File file = new File(location);
                System.out.println(location);
                //拷贝路径
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(file));

                //设置上传路径
                fileMeta.setLocation("personImg/" + mpf.getOriginalFilename());

            } catch (Exception e) {
                e.printStackTrace();
            }
            files.add(fileMeta);
        }
        return new ResultBuilder<List<FileMeta>>().data(files).build();
    }
}
