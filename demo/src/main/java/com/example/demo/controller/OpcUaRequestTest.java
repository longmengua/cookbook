package com.example.demo.controller;

import com.example.demo.entity.Person;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("")
public class OpcUaRequestTest {
    @GetMapping("all")
    public ResponseEntity get(@RequestParam Map map){
        return null;
    }
    @PostMapping("all")
    public ResponseEntity post(@RequestBody Map map){
        return null;
    }
    @GetMapping("")
    public ResponseEntity a(@RequestParam Map map){
        return null;
    }
    @PostMapping("")
    public ResponseEntity b(@RequestBody Map map){
        return null;
    }
}
