package com.cagnosolutions.starter.app.job

import groovy.transform.CompileStatic
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@CompileStatic
@Repository
interface JobRepository extends JpaRepository<Job, Long> {

	@Query("SELECT j FROM Job j WHERE j.status=2")
	List<Job> findAllInvoiced()

	@Query(nativeQuery = true, value = "Select hoey.job.customer_id from hoey.job Where hoey.job.id=:jobId")
	Long findCustomerIdByJob(@Param("jobId") Long jobId);

}
