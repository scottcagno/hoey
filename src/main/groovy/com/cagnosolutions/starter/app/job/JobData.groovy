package com.cagnosolutions.starter.app.job
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

@CompileStatic
@Service(value = "jobService")
class JobService {

	@Autowired
	JobRepository repo

	List<Job> findAll() {
		repo.findAll()
	}

	Page<Job> findAll(int page, int size, String... fields) {
		repo.findAll(new PageRequest(page, size, Sort.Direction.ASC, fields))
	}

	Job findOne(Long id) {
		repo.findOne id
	}

	Job save(Job job) {
		repo.save job
	}

	def delete(Long id) {
		repo.delete id
	}

    List<Job> findAllInvoiced() {
        repo.findAllInvoiced()
    }

	Long findCustomerIdByJob(Long jobId) {
		repo.findCustomerIdByJob(jobId)
	}

	// helper method
	def mergeProperties(source, target) {
		source.properties.each { key, value ->
			if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null)
				target[key as String] = value
		}
	}
}

@CompileStatic
@Repository
interface JobRepository extends JpaRepository<Job, Long> {

    @Query("SELECT j FROM Job j WHERE j.status=2")
    List<Job> findAllInvoiced()

	@Query(nativeQuery = true, value = "Select hoey.job.customer_id from hoey.job Where hoey.job.id=:jobId")
	Long findCustomerIdByJob(@Param("jobId") Long jobId);

}
