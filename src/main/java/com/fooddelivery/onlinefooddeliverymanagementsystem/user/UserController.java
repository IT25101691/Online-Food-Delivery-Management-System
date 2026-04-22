package com.fooddelivery.onlinefooddeliverymanagementsystem.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // ==================== Login ====================

    @GetMapping("/login")
    public String loginPage(Authentication authentication) {
        // Prevent redirect for anonymous user
        if (authentication != null &&
                authentication.isAuthenticated() &&
                !(authentication.getPrincipal().equals("anonymousUser"))) {

            return "redirect:/user/dashboard";
        }
        return "user/login";
    }

    // ==================== Dashboard (Role Based Redirect) ====================

    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication) {

        if (authentication.getAuthorities().contains(
                new SimpleGrantedAuthority("ROLE_ADMIN"))) {

            return "redirect:/admin/dashboard";

        } else if (authentication.getAuthorities().contains(
                new SimpleGrantedAuthority("ROLE_RESTAURANT"))) {

            return "redirect:/restaurant/dashboard";

        } else {
            return "redirect:/order/menu";
        }
    }
}