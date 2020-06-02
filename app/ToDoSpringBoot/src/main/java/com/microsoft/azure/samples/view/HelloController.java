package com.microsoft.azure.samples.view;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.client.RestTemplate;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.microsoft.azure.samples.model.TodoItem;


@Controller
public class HelloController {

    private Logger logger = LogManager.getLogger(HelloController.class.getName());

    @GetMapping({ "/", "/hello" })
    public String hello(Model model,
            @RequestParam(value = "name", required = false, defaultValue = "App Service") String name) {
        TodoItem item = callListToDo();
        model.addAttribute("name", name);
        return "hello";
    }

    @GetMapping({ "/raiseError", "/raiseError" })
    public String raiseError(Model model, @RequestParam(value = "name", required = false) String name)
            throws Throwable {
        logger.info("raiseError");
        if (name == null || name.length() == 0) {
            logger.warn("Wrong HTTP query parameter.");
            Throwable th = new Throwable("name is null");
            throw th;
        }
        model.addAttribute("name", name);
        return "raiseError";
    }

    private TodoItem callListToDo() {
        String uri = "https://ws12651springtodobackend.azurewebsites.net/api/ListToDo";

        RestTemplate restTemplate = new RestTemplate();
        TodoItem item = restTemplate.getForObject(uri, TodoItem.class);

        return item;
    }
}
