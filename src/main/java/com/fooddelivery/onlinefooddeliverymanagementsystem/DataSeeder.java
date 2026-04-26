package com.fooddelivery.onlinefooddeliverymanagementsystem;

import com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant.FoodItem;
import com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant.FoodItemRepository;
import com.fooddelivery.onlinefooddeliverymanagementsystem.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.math.BigDecimal;

@Component
public class DataSeeder implements CommandLineRunner {

    @Autowired
    private FoodItemRepository foodItemRepository;

    @Autowired
    private UserService userService;

    @Override
    public void run(String... args) throws Exception {

        // Seed test users
        userService.seedTestData();

        // Seed food items only if empty
        if (foodItemRepository.count() == 0) {

            foodItemRepository.save(new FoodItem(null,
                    "Chicken Burger",
                    "Juicy grilled chicken with lettuce and mayo",
                    new BigDecimal("450.00"),
                    "Burgers",
                    "https://res.cloudinary.com/demo/image/upload/v1/food/burger.jpg",
                    true));

            foodItemRepository.save(new FoodItem(null,
                    "Margherita Pizza",
                    "Classic tomato sauce with mozzarella cheese",
                    new BigDecimal("1200.00"),
                    "Pizza",
                    "https://res.cloudinary.com/demo/image/upload/v1/food/pizza.jpg",
                    true));

            foodItemRepository.save(new FoodItem(null,
                    "Fried Rice",
                    "Wok fried rice with vegetables and egg",
                    new BigDecimal("350.00"),
                    "Rice",
                    "https://res.cloudinary.com/demo/image/upload/v1/food/rice.jpg",
                    true));

            foodItemRepository.save(new FoodItem(null,
                    "Chocolate Milkshake",
                    "Creamy chocolate milkshake with whipped cream",
                    new BigDecimal("250.00"),
                    "Drinks",
                    "https://res.cloudinary.com/demo/image/upload/v1/food/milkshake.jpg",
                    true));

            foodItemRepository.save(new FoodItem(null,
                    "Garlic Bread",
                    "Toasted bread with garlic butter",
                    new BigDecimal("180.00"),
                    "Sides",
                    "https://res.cloudinary.com/demo/image/upload/v1/food/garlic-bread.jpg",
                    true));

            foodItemRepository.save(new FoodItem(null,
                    "Chocolate Lava Cake",
                    "Warm chocolate cake with molten center",
                    new BigDecimal("320.00"),
                    "Desserts",
                    "https://res.cloudinary.com/demo/image/upload/v1/food/lava-cake.jpg",
                    true));

            System.out.println("✅ Food items seeded successfully!");
        }

        System.out.println("✅ Data seeding complete!");
    }
}