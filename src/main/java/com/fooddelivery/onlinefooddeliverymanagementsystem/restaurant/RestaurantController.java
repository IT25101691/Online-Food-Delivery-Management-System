package com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;

@Controller
@RequestMapping("/restaurant")
public class RestaurantController {

    @Autowired
    private RestaurantService restaurantService;

    // ==================== Dashboard ====================

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalItems",
                restaurantService.getAllFoodItems().size());
        model.addAttribute("incomingOrders",
                restaurantService.getIncomingOrders().size());
        model.addAttribute("acceptedOrders",
                restaurantService.getOrdersByStatus(OrderStatus.ACCEPTED).size());
        model.addAttribute("preparingOrders",
                restaurantService.getOrdersByStatus(OrderStatus.PREPARING).size());
        return "restaurant/dashboard";
    }

    // ==================== Food Item CRUD ====================

    @GetMapping("/menu")
    public String viewMenu(Model model) {
        model.addAttribute("foodItems",
                restaurantService.getAllFoodItems());
        model.addAttribute("newFoodItem", new FoodItem());
        return "restaurant/menu";
    }

    @PostMapping("/menu/add")
    public String addFoodItem(
            @ModelAttribute FoodItem foodItem,
            @RequestParam(value = "image", required = false) MultipartFile image,
            RedirectAttributes redirectAttributes) {
        try {
            restaurantService.addFoodItem(foodItem, image);
            redirectAttributes.addFlashAttribute("success",
                    "Food item added successfully!");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error",
                    "Failed to upload image. Please try again.");
        }
        return "redirect:/restaurant/menu";
    }

    @GetMapping("/menu/edit/{id}")
    public String editFoodItemForm(@PathVariable Long id, Model model) {
        model.addAttribute("foodItem",
                restaurantService.getFoodItemById(id));
        return "restaurant/edit-food-item";
    }

    @PostMapping("/menu/edit/{id}")
    public String editFoodItem(
            @PathVariable Long id,
            @ModelAttribute FoodItem foodItem,
            @RequestParam(value = "image", required = false) MultipartFile image,
            RedirectAttributes redirectAttributes) {
        try {
            restaurantService.updateFoodItem(id, foodItem, image);
            redirectAttributes.addFlashAttribute("success",
                    "Food item updated successfully!");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error",
                    "Failed to upload image. Please try again.");
        }
        return "redirect:/restaurant/menu";
    }

    @PostMapping("/menu/delete/{id}")
    public String deleteFoodItem(@PathVariable Long id,
                                 RedirectAttributes redirectAttributes) {
        restaurantService.deleteFoodItem(id);
        redirectAttributes.addFlashAttribute("success",
                "Food item deleted successfully!");
        return "redirect:/restaurant/menu";
    }

    @PostMapping("/menu/toggle/{id}")
    public String toggleAvailability(@PathVariable Long id,
                                     RedirectAttributes redirectAttributes) {
        restaurantService.toggleAvailability(id);
        redirectAttributes.addFlashAttribute("success",
                "Item availability updated!");
        return "redirect:/restaurant/menu";
    }

    // ==================== Order Management ====================

    @GetMapping("/orders")
    public String viewOrders(Model model) {
        model.addAttribute("incomingOrders",
                restaurantService.getIncomingOrders());
        model.addAttribute("acceptedOrders",
                restaurantService.getOrdersByStatus(OrderStatus.ACCEPTED));
        model.addAttribute("preparingOrders",
                restaurantService.getOrdersByStatus(OrderStatus.PREPARING));
        model.addAttribute("outForDeliveryOrders",
                restaurantService.getOrdersByStatus(OrderStatus.OUT_FOR_DELIVERY));
        model.addAttribute("deliveredOrders",
                restaurantService.getOrdersByStatus(OrderStatus.DELIVERED));
        model.addAttribute("declinedOrders",
                restaurantService.getOrdersByStatus(OrderStatus.DECLINED));
        return "restaurant/orders";
    }

    @PostMapping("/orders/accept/{id}")
    public String acceptOrder(@PathVariable Long id,
                              RedirectAttributes redirectAttributes) {
        restaurantService.acceptOrder(id);
        redirectAttributes.addFlashAttribute("success",
                "Order accepted successfully!");
        return "redirect:/restaurant/orders";
    }

    @PostMapping("/orders/decline/{id}")
    public String declineOrder(@PathVariable Long id,
                               RedirectAttributes redirectAttributes) {
        restaurantService.declineOrder(id);
        redirectAttributes.addFlashAttribute("success",
                "Order declined!");
        return "redirect:/restaurant/orders";
    }

    @PostMapping("/orders/status/{id}")
    public String updateOrderStatus(
            @PathVariable Long id,
            @RequestParam OrderStatus status,
            RedirectAttributes redirectAttributes) {
        restaurantService.updateOrderStatus(id, status);
        redirectAttributes.addFlashAttribute("success",
                "Order status updated!");
        return "redirect:/restaurant/orders";
    }

    @GetMapping("/orders/{id}")
    public String viewOrderDetails(@PathVariable Long id, Model model) {
        model.addAttribute("order",
                restaurantService.getOrderById(id));
        return "restaurant/order-details";
    }
}