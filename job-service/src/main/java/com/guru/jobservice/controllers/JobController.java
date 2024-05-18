package com.guru.jobservice.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guru.jobservice.dtos.CreateUpdateRequest;
import com.guru.jobservice.dtos.FiltersRequest;
import com.guru.jobservice.dtos.JobViewRequest;
import com.guru.jobservice.dtos.PaginatedResponse;
import com.guru.jobservice.model.Job;
import com.guru.jobservice.services.JobService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.UUID;

@RestController
@RequestMapping("/jobs")
public class JobController {

    private final JobService jobService;

    @Autowired
    public JobController(JobService jobService) {
        this.jobService = jobService;
    }

    @GetMapping("/{id}")
    public Job getJobById(@PathVariable UUID id) throws Exception {
        return jobService.getJobById(id);
    }

    @PostMapping("/")
    public Job createJob(@Valid @RequestBody CreateUpdateRequest createUpdateRequest) throws JsonProcessingException {
        return jobService.createJob(createUpdateRequest);
    }

    @PutMapping("/{id}")
    public void updateJob(@PathVariable UUID id, @Valid @RequestBody CreateUpdateRequest createUpdateRequest) throws Exception{
         jobService.updateJob(id, createUpdateRequest);
    }

    @DeleteMapping("/{id}")
    public void deleteJob(@PathVariable UUID id) {
        jobService.deleteJobById(id);
    }

    @GetMapping("/")
    public PaginatedResponse<Job> getAllJobs(@Valid FiltersRequest filtersRequest) {
        return jobService.getAllJobs(filtersRequest);
    }

    @PostMapping("/view")
    public void viewJob(@Valid @RequestBody JobViewRequest viewRequest) {
        jobService.markJobAsViewed(viewRequest);
    }

}

