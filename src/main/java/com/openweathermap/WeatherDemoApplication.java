package com.openweathermap;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class WeatherDemoApplication {

	public static void main(String[] args) {
		// Start spring boot application
		// prerequisites: weather API running on port 8080
		SpringApplication.run(WeatherDemoApplication.class, args);
	}

}
