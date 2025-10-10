package com.sajikitchen.saji_cashier;

import jakarta.annotation.PostConstruct;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.TimeZone;

@SpringBootApplication
public class SajiCashierApplication {
	@PostConstruct
	public void init() {
		// Mengatur default timezone untuk seluruh aplikasi ke WIB (UTC+7)
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Jakarta"));
	}

	public static void main(String[] args) {
		SpringApplication.run(SajiCashierApplication.class, args);
	}

}
