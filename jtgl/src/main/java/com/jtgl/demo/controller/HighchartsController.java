package com.jtgl.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.platform.controller.BaseController;

@Controller
@RequestMapping("/api/v1/highcharts")
public class HighchartsController extends BaseController {

	
    @RequestMapping(value = "/xrange", method = RequestMethod.GET)
    public String xrange(Model model) {
        return "demo/highcharts/xrange";
    }
    
}
