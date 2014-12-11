package com.cagnosolutions.starter.app.room

import groovy.transform.CompileStatic
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@CompileStatic
@Repository
interface RoomRepository extends JpaRepository<Room, Long> {

}
