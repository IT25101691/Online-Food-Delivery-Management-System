package com.fooddelivery.onlinefooddeliverymanagementsystem.order;

import com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    // Get orders by user (customer's order history)
    List<Order> findByUserId(Long userId);

    // Get orders by status (restaurant uses this)
    List<Order> findByStatus(OrderStatus status);

    // Get orders by user and status
    List<Order> findByUserIdAndStatus(Long userId, OrderStatus status);

    // Get all orders sorted by latest first
    List<Order> findAllByOrderByCreatedAtDesc();

    // Get user orders sorted by latest first
    List<Order> findByUserIdOrderByCreatedAtDesc(Long userId);
}