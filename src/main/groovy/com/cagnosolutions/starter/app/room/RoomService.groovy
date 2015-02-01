package com.cagnosolutions.starter.app.room

import com.cagnosolutions.starter.app.validators.RoomValidator
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Service

@CompileStatic
@Service
class RoomService {

	@Autowired
	RoomRepository repo

	List<Room> findAll() {
		repo.findAll()
	}

	Page<Room> findAll(int page, int size, String... fields) {
		repo.findAll(new PageRequest(page, size, Sort.Direction.ASC, fields))
	}

	Room findOne(Long id) {
		repo.findOne id
	}

	Room save(Room room) {
		repo.save room
	}

	def delete(Long id) {
		repo.delete id
	}

	Room generateFromValidator(RoomValidator roomValidator) {
		def room = new Room()
		mergeProperties roomValidator, room
		room
	}

	// helper method
	static def mergeProperties(source, target) {
		source.properties.each { key, value ->
			if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null)
				target[key as String] = value
		}
	}

}

