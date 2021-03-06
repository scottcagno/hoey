package com.cagnosolutions.starter.app.material

import com.cagnosolutions.starter.app.validators.MaterialValidator
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Service

@CompileStatic
@Service
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

	List<Material> findAllByCategory(String cat) {
		repo.findAllByCategory(cat);
	}

	Set<String> getUniqueItemsByCategory() {
		List<String> categories = new ArrayList<>();
		List<Material> allMaterials = repo.findAll();
		for(Material material : allMaterials) {
			categories.add(material.cat);
		}
		new HashSet<String>(categories);
	}

	Material generateFromValidator(MaterialValidator materialValidator) {
		def material = new Material()
		mergeProperties materialValidator, material
		material
	}

	// helper method
	static def mergeProperties(source, target) {
		source.properties.each { key, value ->
			if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null)
				target[key as String] = value
		}
	}
}


