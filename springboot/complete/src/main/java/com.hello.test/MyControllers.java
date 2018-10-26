package com.hello.test;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.atomic.AtomicLong;


@RestController
@RequestMapping("/test")
class MyControllers {

    private static final String template = "Hello, %s!";
    private final AtomicLong counter = new AtomicLong();

    @RequestMapping("/abc")
    public Greeting nameIsNotImportant(@RequestParam(value="name", defaultValue="this is a testfasdfasdf") String name) {
        return new Greeting(counter.incrementAndGet(),
                String.format(template, name));
    }


    @RequestMapping("/abcd")
    public Greeting greeting(@RequestParam(value="name", defaultValue="this is a te   st") String name) {
        return new Greeting(counter.incrementAndGet(),
                String.format(template, name));
    }
}
