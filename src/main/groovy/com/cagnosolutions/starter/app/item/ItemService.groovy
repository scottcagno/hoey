package com.cagnosolutions.starter.app.item
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Service

@CompileStatic
@Service
class ItemService {

	@Autowired
	ItemRepository repo

	List<Item> findAll() {
		repo.findAll()
	}

	Page<Item> findAll(int page, int size, String... fields) {
		repo.findAll(new PageRequest(page, size, Sort.Direction.ASC, fields))
	}

	Item findOne(Long id) {
		repo.findOne id
	}

	Item save(Item item) {
		repo.save item
	}

	def delete(Long id) {
		repo.delete id
	}

	boolean exists(Long materialId) {
		repo.doesExists(materialId) > 0
	}

}

