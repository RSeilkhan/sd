package com.project.distens.repositories;

import com.project.distens.entities.NewsPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsPostRepository extends JpaRepository<NewsPost, Long> {

    List<NewsPost> findByAuthorEmail(String email);
}
