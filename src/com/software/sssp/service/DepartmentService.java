package com.software.sssp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.software.sssp.entity.Department;
import com.software.sssp.repository.DepartmentRepository;

@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentRepository departmentRepository;
	
	@Transactional(readOnly=true)
	public List<Department> getAll() {
		return departmentRepository.getAll();
	}

}
