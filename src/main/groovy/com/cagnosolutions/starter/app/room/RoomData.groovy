package com.cagnosolutions.starter.app.room
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
@Service(value = "roomService")
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

}

@CompileStatic
@Repository
interface RoomRepository extends JpaRepository<Room, Long> {

}
