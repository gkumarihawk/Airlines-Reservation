package com.synergisticit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GatewayController {
	
	@RequestMapping("/index")
	public String index() {
		return "index";
	}

}
