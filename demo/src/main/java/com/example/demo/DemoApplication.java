package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
//        int ans = singleNumber(new int[]{1, 9, -33, 2, 3, 5, 6, 2, 3, 1, 9, 6, 5});
//        System.out.println(ans);
    }

    //LeetCode
    //a linear runtime complexity means a for-loop
//	public static int singleNumber(int[] nums) {
//		// use property of xor, any number xor with 0 is still itself
//		// every number xor with itself will be 0
//		// eg: 0 ^ 3 ^ 4 ^ 3 = 4
//		int xor = 0;
//		for (int i : nums) {
//			xor ^= i;
//		}
//		return xor;
//	}

//    public void run(String... args) throws Exception {
//        System.out.println("using environment: " + myConfig.getEnvironment());
//        System.out.println("name: " + myConfig.getName());
//        System.out.println("servers: " + myConfig.getServers());
//    }
}
