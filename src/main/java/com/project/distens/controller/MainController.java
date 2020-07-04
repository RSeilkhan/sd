package com.project.distens.controller;

import com.project.distens.entities.*;
import com.project.distens.repositories.*;
import com.project.distens.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.websocket.server.PathParam;
import java.util.*;


@Controller
public class MainController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    UserService userService;

    @Autowired
    NewsPostRepository newsPostRepository;

    @Autowired
    CommentRepository commentRepository;

    @Autowired
    FriendRepository friendRepository;




    public Users getUserData(){
        Users userData = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof  AnonymousAuthenticationToken)){
            org.springframework.security.core.userdetails.User secUser = (org.springframework.security.core.userdetails.User)authentication.getPrincipal();
            userData = userRepository.findByEmail(secUser.getUsername());
        }
        return userData;
    }




    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/addFriend")
    public String addFriend(@RequestParam(name = "friendId") Long id){

        String redirect = "redirect:/profile";

     /*   Optional<Users> users = userRepository.findById(id);
        Set<Friend> friends = new HashSet<>();
        Friend userFriend = friendRepository.adds(users);
        friends.add(userFriend);*/
        Long owner = getUserData().getId();


        Role userRole = roleRepository.getOne(1L); //1 способ

        friendRepository.save(new Friend(null, owner, id, true));


        return redirect;
    }


    @GetMapping(value = "/users/{email}") //visit profiles
    public String visit(ModelMap model, @PathVariable(name = "email") String email){

        List<NewsPost> allNews = newsPostRepository.findByAuthorEmail(email);
        model.addAttribute("allNews", allNews);

        Users user  = userRepository.findByEmail(email);
        model.addAttribute("allUsers",  user);

        return "visit_profile";
    }



    @GetMapping(value = "/users_list")
    public String users_lists(ModelMap model){


        List<Users> user = userRepository.findAll();
        model.addAttribute("allUsers", user);

        return "users_list";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping(value = "/profile")
    public String account(ModelMap model){
        List<NewsPost> allNews = newsPostRepository.findByAuthorEmail(getUserData().getEmail());
        model.addAttribute("allNews", allNews);
        System.out.println("Email" + getUserData().getEmail());
      //  Optional<Users> users = userRepository.findById(id);
        model.addAttribute("user", getUserData());





        //id, email, password, name, surname, isactive(bool), roles, gender, city, telnumber, birthday

        return "profile";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping(value = "/chat")
    public String chat(Model model){
        model.addAttribute("user", getUserData());

        return "sockjs-message";
    }

    @GetMapping(value = "/auth_reg")
    public String auth_reg(){
        return "auth_reg";
    }

    @PostMapping(value = "/register")
    public String register(RedirectAttributes redirectAttributes,
                           @RequestParam(name = "email") String email,
                           @RequestParam(name = "password") String password,
                           @RequestParam(name = "name") String name,
                           @RequestParam(name = "surName") String surName,
                           @RequestParam(name = "gender") String gender,
                           @RequestParam(name = "birthday") Integer birthday,
                           @RequestParam(name = "tel_number") String tel_number,
                           @RequestParam(name = "city") String city,
                           @RequestParam(name = "about") String about,
                           @RequestParam(name = "avatar") String avatar


    )
    {
        String redirect = "redirect:/auth_reg?registration_error";

        Users user = userRepository.findByEmail(email);
        if(user==null && password.length()>4 && password!=null){
            Set<Role> roles = new HashSet<>();
            Role userRole = roleRepository.getOne(1L); //1 способ

            roles.add(userRole);
            user = new Users(email, password,  name, surName, true, roles,  gender, city,  tel_number,  about,  birthday, avatar);
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("success","Everything good");

            redirect = "redirect:/auth_reg?registration_success";

        }

        return redirect;
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/refpass")
    public String refpass(@RequestParam(name = "id") Long id,
                          @RequestParam(name = "password") String password){

        String redirect = "redirect:/profile?password_not_refreshed";

        Optional<Users> user = userRepository.findById(id);
        if(user.isPresent()){
            user.get().setPassword(password);
            userService.registerUser(user.get());
            redirect = "redirect:/profile?password_refreshed";
        }

        return redirect;
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping(value = "/edit_profile")
    public String edit_profile(ModelMap model){
        model.addAttribute("user", getUserData());

        return "edit_profile";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/editprof")
    //@PreAuthorize("#user_id == principal.userId")
    public String editprof(ModelMap model, @RequestParam(name = "id") Long id,
                           @RequestParam(name = "email") String email,
                           @RequestParam(name = "name") String name,
                           @RequestParam(name = "surname") String surname,
                           @RequestParam(name = "gender") String gender,
                           @RequestParam(name = "birthday") Integer birthday,
                           @RequestParam(name = "tel_number") String tel_number,
                           @RequestParam(name = "city") String city,
                           @RequestParam(name = "about") String about,
                           @RequestParam(name = "avatar") String avatar

                           ){

        String redirect = "redirect:/edit_profile?profile_not_refreshed";
        model.addAttribute("user", getUserData());

        Optional<Users> user = userRepository.findById(id);
        if(user.isPresent()){
            user.get().setName(name);
            user.get().setEmail(email);
            user.get().setSurname(surname);
            user.get().setGender(gender);
            user.get().setTel_number(tel_number);
           user.get().setCity(city);
            user.get().setAbout(about);
            user.get().setBirthday(birthday);
            user.get().setAvatar(avatar);



            userService.registerUser(user.get());
            redirect = "redirect:/profile?password_refreshed";
        }

        return redirect;
    }

    @GetMapping(value = "/profile_admin")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String profile_admin(ModelMap model){

        List<Users> allUsers = userRepository.findAll();
        model.addAttribute("allUsers", allUsers);

        Role moderator = roleRepository.getOne(3L);
        model.addAttribute("moderator", moderator);

        Role admin = roleRepository.getOne(2L);
        model.addAttribute("admin", admin);

        return "profile_admin";
    }

    @GetMapping(value = "/profile_moderator")
    @PreAuthorize("hasRole('ROLE_MODERATOR')")
    public String profile_moderator(ModelMap model){

        List<Users> allUsers = userRepository.findAll();
        model.addAttribute("allUsers", allUsers);

        Role moderator = roleRepository.getOne(3L);
        model.addAttribute("moderator", moderator);

        Role admin = roleRepository.getOne(2L);
        model.addAttribute("admin", admin);

        return "profile_moderator";
    }



    @PostMapping(value = "/addUserModerator")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String addUserModerator(@RequestParam(name = "email") String email,
                                   @RequestParam(name = "password") String password,
                                   @RequestParam(name = "name") String name,
                                   @RequestParam(name = "surName") String surName,
                                   @RequestParam(name = "tel_number") String tel_number
                                   ){

        String redirect = "redirect:/profile_admin?user/moderator_added_error";

        Users user = userRepository.findByEmail(email);
        if(user==null){

            Set<Role> roles = new HashSet<>();
            roles.add(roleRepository.getOne(3L));
            String avatar = "https://vignette.wikia.nocookie.net/all-interesting/images/b/b6/%D0%9C%D0%BE%D0%B4%D0%B5%D1%80%D0%B0%D1%82%D0%BE%D1%80_%D1%87%D0%B0%D1%82%D0%B0.jpg/revision/latest/scale-to-width-down/340?cb=20141018105815&path-prefix=ru";
            user = new Users(email, password,  name, surName, true, roles,  null, null,  tel_number,  null,  null, avatar);
            userService.registerUser(user);
            redirect = "redirect:/profile_admin?user/moderator_added_success";

        }

        return redirect;
    }


    @PostMapping(value = "/addUser")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String addUser(@RequestParam(name = "email") String email,
                                   @RequestParam(name = "USER") int user_role){

        String redirect = "redirect:/profile_admin?user/user_added_error";

        Users user = userRepository.findByEmail(email);
        if(user==null){

            Set<Role> roles = new HashSet<>();
            if(user_role==1)
                roles.add(roleRepository.getOne(1L));

            //user = new Users(null, email, password, name, surName, true, roles);
            userService.registerUser(user);
            redirect = "redirect:/profile_admin?user/moderator_added_success";

        }

        return redirect;
    }


    @PostMapping(value = "/refPassword")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String refPassword(@RequestParam(name = "id") Long id,
                              @RequestParam(name = "password") String password){

        String redirect = "redirect:/profile_admin?password_not_refreshed";

        Optional<Users> user = userRepository.findById(id);
        if(user.isPresent()){
            user.get().setPassword(password);
            userService.registerUser(user.get());
            redirect = "redirect:/profile_admin?password_refreshed";
        }

        return redirect;
    }

    @PostMapping(value = "/blockUser")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MODERATOR')")
    public String blockUser(@RequestParam(name = "id") Long id){

        Optional<Users> user = userRepository.findById(id);
        if(user.isPresent()){
            user.get().setActive(false);
            userRepository.save(user.get());
        }


        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof AnonymousAuthenticationToken)){
            org.springframework.security.core.userdetails.User secUser = (org.springframework.security.core.userdetails.User)authentication.getPrincipal();
            Users requester = userRepository.findByEmail(secUser.getUsername());
            if(requester.getRoles().contains(roleRepository.getOne(3L)))
                return "redirect:/profile_moderator";
        }


        return "redirect:/profile_admin";
    }

    @PostMapping(value = "/unBlockUser")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MODERATOR')")
    public String unBlockUser(@RequestParam(name = "id") Long id){

        Optional<Users> user = userRepository.findById(id);
        if(user.isPresent()){
            user.get().setActive(true);
            userRepository.save(user.get());
        }


        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof AnonymousAuthenticationToken)){
            org.springframework.security.core.userdetails.User secUser = (org.springframework.security.core.userdetails.User)authentication.getPrincipal();
            Users requester = userRepository.findByEmail(secUser.getUsername());
            if(requester.getRoles().contains(roleRepository.getOne(3L)))
                return "redirect:/profile_moderator";
        }

        return "redirect:/profile_admin";
    }

    ///////////////////////////////END USER//////////////////////////////////////////

    //////////////////////NEWS POST///////////////////////////////////////////////////////

    @GetMapping(value = "/")
    public String index(ModelMap model){

        List<NewsPost> allNews = newsPostRepository.findAllByDate();
        model.addAttribute("allNews", allNews);

        List<Users> user = userRepository.findAll();
        model.addAttribute("allUsers", user);
//        long id = 3;
//        List<Comment> comment = commentRepository.countCommentByNewsPost(id);
//        model.addAttribute("countComment", comment);



        return "index";
    }




    @PostMapping(value = "/addPost")
    public String addPost(@RequestParam(name = "title") String title,
                          @RequestParam(name = "shortContent") String shortContent,
                          @RequestParam(name = "content") String content,
                          @RequestParam(name = "image") String image
    ){


        Users author = null;

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof AnonymousAuthenticationToken)){
            org.springframework.security.core.userdetails.User secUser = (org.springframework.security.core.userdetails.User)authentication.getPrincipal();
            author = userRepository.findByEmail(secUser.getUsername());
        }
        newsPostRepository.save(new NewsPost(title, shortContent, content, author, new Date(),image));

        return "redirect:/";
    }

    @GetMapping(value = "/postDetails/{id}")
    public String postDetails(ModelMap model,
                           @PathVariable(name = "id") Long id){
        long a = id;
        Optional<NewsPost> post = newsPostRepository.findById(a);
        //model.addAttribute("post", post.orElse(new NewsPost(null, "No Name", "No Name", "No Name", null, null)));
        model.addAttribute("post", post.orElse(new NewsPost(null, null, null, null, null, null)));

        Role user = roleRepository.getOne(1L);
        model.addAttribute("user", user);

        List<Comment> allComments = commentRepository.findByNewsPostId(a);
        model.addAttribute("allComments", allComments);

        Users adam = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof AnonymousAuthenticationToken)){
            org.springframework.security.core.userdetails.User secUser = (org.springframework.security.core.userdetails.User)authentication.getPrincipal();
            adam = userRepository.findByEmail(secUser.getUsername());
        }
        model.addAttribute("adam", adam);

        return "post";
    }

    @PostMapping("/editPost")
    public String editPost(@RequestParam(name = "id") Long id,
                           @RequestParam(name = "title") String title,
                           @RequestParam(name = "shortContent") String shortContent,
                           @RequestParam(name = "content") String content){

        Optional<NewsPost> post = newsPostRepository.findById(id);
        if(post.isPresent()){
            post.get().setTitle(title);
            post.get().setShortContent(shortContent);
            post.get().setContent(content);

            newsPostRepository.save(post.get());
        }


        return "redirect:/newsPage/"+id;
    }


    @PostMapping("/deletePost")
    public String deletePost(@RequestParam(name = "id") Long id){

        Optional<NewsPost> post = newsPostRepository.findById(id);
        if(post.isPresent()){
            newsPostRepository.delete(post.get());
        }

        return "redirect:/";
    }

    /////////////////////////////////COMMENT//////////////////////////////////////////////////////////

    @PostMapping(value = "/addComment")
    public String addComment(@RequestParam(name = "postId") Long postId,
                             @RequestParam(name = "comment") String comment){

        Users author = null;

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof AnonymousAuthenticationToken)){
            org.springframework.security.core.userdetails.User secUser = (org.springframework.security.core.userdetails.User)authentication.getPrincipal();
            author = userRepository.findByEmail(secUser.getUsername());
        }



        commentRepository.save(new Comment(author, newsPostRepository.getOne(postId), comment, new Date()));

        return "redirect:/newsPage/"+postId;
    }


    @PostMapping(value = "/changeComment")
    public String changeComment(@RequestParam(name = "postId") Long postId,
                                @RequestParam(name = "comment_id") Long comment_id,
                                @RequestParam(name = "changedComment") String changedComment){

        Optional<Comment> comment = commentRepository.findById(comment_id);
        if(comment.isPresent()){
            comment.get().setComment(changedComment);
            commentRepository.save(comment.get());
        }

        return "redirect:/newsPage/"+postId;
    }

    @PostMapping(value = "/deleteComment")
    public String deleteComment(@RequestParam(name = "postId") Long postId,
                                @RequestParam(name = "comment_id") Long comment_id){

        commentRepository.delete(commentRepository.getOne(comment_id));

        return "redirect:/newsPage/"+postId;
    }
}
