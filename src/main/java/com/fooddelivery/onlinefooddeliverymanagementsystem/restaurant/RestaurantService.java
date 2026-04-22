package com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant;

import com.fooddelivery.onlinefooddeliverymanagementsystem.order.Order;
import com.fooddelivery.onlinefooddeliverymanagementsystem.order.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public class RestaurantService {

    @Autowired
    private FoodItemRepository foodItemRepository;

    @Autowired
    private OrderRepository orderRepository;

    // ==================== Food Item CRUD ====================

    public List<FoodItem> getAllFoodItems() {
        return foodItemRepository.findAll();
    }

    public List<FoodItem> getAvailableFoodItems() {
        return foodItemRepository.findByAvailableTrue();
    }

    public List<FoodItem> getFoodItemsByCategory(String category) {
        return foodItemRepository.findByCategory(category);
    }

    public List<FoodItem> searchFoodItems(String name) {
        return foodItemRepository.findByNameContainingIgnoreCase(name);
    }

    public FoodItem getFoodItemById(Long id) {
        return foodItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Food item not found!"));
    }

    public FoodItem addFoodItem(FoodItem foodItem,
                                MultipartFile image) throws IOException {
        return foodItemRepository.save(foodItem);
    }

    public FoodItem updateFoodItem(Long id, FoodItem updatedItem,
                                   MultipartFile image) throws IOException {
        FoodItem existing = getFoodItemById(id);
        existing.setName(updatedItem.getName());
        existing.setDescription(updatedItem.getDescription());
        existing.setPrice(updatedItem.getPrice());
        existing.setCategory(updatedItem.getCategory());
        existing.setAvailable(updatedItem.isAvailable());

        return foodItemRepository.save(existing);
    }

    public void deleteFoodItem(Long id) {
        foodItemRepository.deleteById(id);
    }

    public void toggleAvailability(Long id) {
        FoodItem item = getFoodItemById(id);
        item.setAvailable(!item.isAvailable());
        foodItemRepository.save(item);
    }

    // ==================== Order Management ====================

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public List<Order> getOrdersByStatus(OrderStatus status) {
        return orderRepository.findByStatus(status);
    }

    public Order getOrderById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found!"));
    }

    public Order acceptOrder(Long id) {
        Order order = getOrderById(id);
        order.setStatus(OrderStatus.ACCEPTED);
        return orderRepository.save(order);
    }

    public Order declineOrder(Long id) {
        Order order = getOrderById(id);
        order.setStatus(OrderStatus.DECLINED);
        return orderRepository.save(order);
    }

    public Order updateOrderStatus(Long id, OrderStatus status) {
        Order order = getOrderById(id);
        order.setStatus(status);
        return orderRepository.save(order);
    }

    public List<Order> getIncomingOrders() {
        return orderRepository.findByStatus(OrderStatus.PAYMENT_SUCCESS);
    }


}