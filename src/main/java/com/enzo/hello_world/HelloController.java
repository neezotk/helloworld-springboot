package com.enzo.hello_world;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @RequestMapping( "/")
    public String hello(){
        return "Hello World";
    }
}