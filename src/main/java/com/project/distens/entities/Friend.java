package com.project.distens.entities;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_friends")
public class Friend {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name="ownerId")
    private Long owner;

    @Column(name="friend_id")
    private Long friend;

    private boolean isActive;

    public Friend(Long id, Long owner, Long friend, boolean isActive) {
        this.id = id;
        this.owner = owner;
        this.friend = friend;
        this.isActive = isActive;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOwner() {
        return owner;
    }

    public void setOwner(Long owner) {
        this.owner = owner;
    }

    public Long getFriend() {
        return friend;
    }

    public void setFriend(Long friend) {
        this.friend = friend;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

}
