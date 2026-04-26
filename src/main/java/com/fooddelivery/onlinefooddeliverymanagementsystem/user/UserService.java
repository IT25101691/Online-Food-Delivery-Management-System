package com.fooddelivery.onlinefooddeliverymanagementsystem.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.Collections;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Lazy
    @Autowired
    private PasswordEncoder passwordEncoder;

    // ==================== Spring Security ====================

    @Override
    public UserDetails loadUserByUsername(String email)
            throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() ->
                        new UsernameNotFoundException("User not found: " + email));

        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPassword(),
                Collections.singletonList(
                        new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
                )
        );
    }

    // ==================== Get User ====================

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found!"));
    }

    // ==================== Seed Test Data ====================

    public void seedTestData() {
        // Seed test customer
        if (!userRepository.existsByEmail("customer@test.com")) {
            User customer = new User();
            customer.setName("Test Customer");
            customer.setEmail("customer@test.com");
            customer.setPassword(passwordEncoder.encode("test1234"));
            customer.setPhone("0771234567");
            customer.setAddress("123 Test Street, Colombo");
            customer.setRole(User.Role.USER);
            userRepository.save(customer);
        }

        // Seed default admin
        if (!userRepository.existsByEmail("admin123@gmail.com")) {
            User admin = new User();
            admin.setName("Super Admin");
            admin.setEmail("admin123@gmail.com");
            admin.setPassword(passwordEncoder.encode("Admin@1234"));
            admin.setPhone("0000000000");
            admin.setAddress("Admin HQ");
            admin.setRole(User.Role.ADMIN);
            userRepository.save(admin);
        }

        // Seed restaurant user
        if (!userRepository.existsByEmail("restaurant@test.com")) {
            User restaurant = new User();
            restaurant.setName("Test Restaurant");
            restaurant.setEmail("restaurant@test.com");
            restaurant.setPassword(passwordEncoder.encode("test1234"));
            restaurant.setPhone("0777654321");
            restaurant.setAddress("456 Food Street, Colombo");
            restaurant.setRole(User.Role.RESTAURANT);
            userRepository.save(restaurant);
        }
    }
}