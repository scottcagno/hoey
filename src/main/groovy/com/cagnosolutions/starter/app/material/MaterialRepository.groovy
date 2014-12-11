package com.cagnosolutions.starter.app.material

import groovy.transform.CompileStatic
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@CompileStatic
@Repository
interface MaterialRepository extends JpaRepository<Material, Long> {
	@Query("SELECT m FROM Material m WHERE m.cat=:cat")
	List<Material> findAllByCategory(@Param("cat") String cat);

}
