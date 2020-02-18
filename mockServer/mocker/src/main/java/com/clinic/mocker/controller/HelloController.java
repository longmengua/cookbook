package com.clinic.mocker.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.*;

@RestController
public class HelloController {

    @RequestMapping("/{path}")
    public String redirect(@PathVariable String path) {
        String toReturn = "";
        try {
            /**
             * @apiNote FileInputStream is for reading files which is outside of this project
             * @apiNote getResource is for reading files which is within this project
             * @apiNote getResource with "/**", means start form root path, and with "./",
             *                      means the parent path of this current class.
             * */
            FileInputStream filePath4 = new FileInputStream("./" + path + ".json");
            System.out.println(filePath4);
            System.out.println();
//            String filePath2 = this.getClass().getResource("./").toString();
//            System.out.println("=============" + filePath2);
//            String filePath = this.getClass().getResource("/hello.txt").toString();
//            System.out.println("=============" + filePath);
            InputStreamReader inputStreamReader = new InputStreamReader(filePath4,"UTF-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            toReturn = bufferedReader.lines().reduce((str1, str2) -> str1 + str2).get();
//            System.out.println(toReturn);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println(e.getStackTrace());
            toReturn = "no such file or directory";
        }
        return toReturn;
    }

    @RequestMapping("/")
    public String index() {
        return redirect("");
    }
}