package com.cagnosolutions.starter.app.material

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service
/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Service(value = "materialService")
class MaterialService {

	@Autowired
	MaterialRepository repo

	List<Material> findAll() {
		repo.findAll()
	}

	Page<Material> findAll(int page, int size, String... fields) {
		repo.findAll(new PageRequest(page, size, Sort.Direction.ASC, fields))
	}

	Material findOne(Long id) {
		repo.findOne id
	}

	Material save(Material material) {
		repo.save material
	}

	def delete(Long id) {
		repo.delete id
	}

}

@CompileStatic
@Repository
interface MaterialRepository extends JpaRepository<Material, Long> {

}
