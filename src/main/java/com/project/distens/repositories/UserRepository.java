package com.project.distens.repositories;

import com.project.distens.entities.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<Users, Long> {

    Users findByEmail(String email);
    //Users findById(Long id);
    Optional<Users> findById(Long id);
    Optional<Users> findByCity(String city);



}
