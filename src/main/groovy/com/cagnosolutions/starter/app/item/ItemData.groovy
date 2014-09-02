package com.cagnosolutions.starter.app.item

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
@Service(value = "itemService")
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

@CompileStatic
@Repository
interface ItemRepository extends JpaRepository<Item, Long> {

	@Query("SELECT COUNT(i.id) FROM Item i WHERE i.material.id=:materialId")
	int doesExists(@Param("materialId") Long materialId)
}
