package com.project.distens.repositories;

import com.project.distens.entities.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface CommentRepository extends JpaRepository<Comment, Long>, CrudRepository<Comment, Long> {

    List<Comment> findByNewsPostId(Long id);

//    @Query(value = "SELECT COUNT(comment) FROM t_comments WHERE news_post_id=3")
//    List<Comment> count
}
