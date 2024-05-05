package com.guru.jobservice.controllers;

import com.guru.jobservice.model.Category;
import com.guru.jobservice.services.CategoryService;
import com.guru.jobservice.services.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/")
    public List<Category> getCategoriesWithSubcategories(
            @RequestParam(required = false)
            @com.guru.jobservice.validators.UUID
            String categoryId) {

        UUID categoryUUID = categoryId != null ? UUID.fromString(categoryId) : null;
        return categoryService.getCategories(categoryUUID);
    }
}
