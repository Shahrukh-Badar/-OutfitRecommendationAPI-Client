package com.openweathermap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import com.openweathermap.model.Recommendation;

@Controller
public class MainController {

	@GetMapping("/index")
	public String init() {
		return "index";
	}

//	@RequestMapping("/myRec")
//	@ResponseBody
//	public Recommendation myRec(@RequestParam String name) {
//		Recommendation rec;
//		try {
//			RestTemplate restTemp = new RestTemplate();
//			rec = restTemp.getForObject("http://localhost:8080/getoutfit?name=" + name, Recommendation.class);
//		} catch (Exception e) {
//			rec = new Recommendation();
//			rec.setOutfitLevel("ERROR.");
//			rec.setTemperature("ERROR.");
//		}
//		return rec;
//	}

	// To get data from microservice running on localhost port 8080.
	// Parameter 'name' needs city name.
	@RequestMapping(value = "/myReccomendation/{name}", method = RequestMethod.GET)
	@ResponseBody
	public Recommendation myReccomendation(@PathVariable("name") String name) {
		Recommendation rec;
		try {
			RestTemplate restTemp = new RestTemplate();
			rec = restTemp.getForObject("http://localhost:8080/getoutfit?name=" + name, Recommendation.class);
		} catch (Exception e) {
			rec = new Recommendation();
			rec.setOutfitLevel("ERROR.");
			rec.setTemperature("ERROR.");
		}
		return rec;
	}
}
