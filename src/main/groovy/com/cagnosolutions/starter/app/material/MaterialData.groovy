package com.cagnosolutions.starter.app.material

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
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

	List<Material> findAllByCategory(String cat, String sort) {
		if (sort == null) {sort == "id"}
		repo.findAllByCategory(cat, sort);
	}

	Set<String> getUniqueItemsByCategory() {
		List<String> categories = new ArrayList<>();
		List<Material> allMaterials = repo.findAll();
		for(Material material : allMaterials) {
			categories.add(material.cat);
		}
		new HashSet<String>(categories);
	}


}

@CompileStatic
@Repository
interface MaterialRepository extends JpaRepository<Material, Long> {
	@Query("SELECT m FROM Material m WHERE m.cat=:cat ORDER BY m.(:sort)")
	List<Material> findAllByCategory(@Param("cat") String cat, @Param("sort") String sort);

}
