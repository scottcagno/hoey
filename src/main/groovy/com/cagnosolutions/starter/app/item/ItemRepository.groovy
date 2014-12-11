package com.cagnosolutions.starter.app.item

import groovy.transform.CompileStatic
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@CompileStatic
@Repository
interface ItemRepository extends JpaRepository<Item, Long> {

	@Query("SELECT COUNT(i.id) FROM Item i WHERE i.material.id=:materialId")
	int doesExists(@Param("materialId") Long materialId)
}
