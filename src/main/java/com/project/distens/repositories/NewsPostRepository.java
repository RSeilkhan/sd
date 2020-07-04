package com.project.distens.repositories;

import com.project.distens.entities.NewsPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsPostRepository extends JpaRepository<NewsPost, Long> {

    @Query(value="SELECT * FROM t_newspost ORDER BY post_date DESC", nativeQuery = true)
    List<NewsPost> findAllByDate();

    List<NewsPost> findByAuthorEmail(String email);
}
