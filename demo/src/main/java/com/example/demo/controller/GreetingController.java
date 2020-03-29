package com.example.demo.controller;

import com.example.demo.entity.Person;
import com.example.demo.repository.PersonRepository;
import com.example.demo.service.GreetingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/person/")
public class GreetingController {

    @Autowired
    GreetingService greetingService;

    @Autowired
    PersonRepository personRepository;

    @GetMapping("generated")
    public Person test(){
        return personRepository.save(new Person());
    }

    @GetMapping("all")
    public List<Person> all(){
        List<Person> people = personRepository.findAll();
        return people;
    }

    @GetMapping("person")
    public Person get(@RequestParam String id){
        Person p = personRepository.getOne(id);
        return p;
    }

    @PostMapping("person")
    public Person save(@RequestBody Person person){
        Person p = personRepository.save(person);
        return p;
    }

    @PutMapping("person")
    public Person update(@RequestBody Person person){
        Person p = personRepository.save(person);
        return p;
    }

    @DeleteMapping("person")
    public Boolean delete(@RequestBody String id){
        try{
            personRepository.deleteById(id);
            return true;
        }catch (Exception e){
            return false;
        }
    }

}
