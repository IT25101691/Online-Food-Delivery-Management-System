package com.fooddelivery.onlinefooddeliverymanagementsystem.order;

import com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant.FoodItem;
import com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant.FoodItemRepository;
import com.fooddelivery.onlinefooddeliverymanagementsystem.restaurant.OrderStatus;
import com.fooddelivery.onlinefooddeliverymanagementsystem.user.User;
import com.fooddelivery.onlinefooddeliverymanagementsystem.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private FoodItemRepository foodItemRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderSummaryService orderSummaryService;

    // ==================== Place Order ====================

    public Order createPendingOrder(String customerEmail,
                                    Map<Long, Integer> cartItems) {
        User user = userService.getUserByEmail(customerEmail);

        List<Order.OrderItem> orderItems = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        for (Map.Entry<Long, Integer> entry : cartItems.entrySet()) {
            FoodItem foodItem = foodItemRepository.findById(entry.getKey())
                    .orElseThrow(() -> new RuntimeException("Food item not found!"));

            Order.OrderItem orderItem = new Order.OrderItem(
                    foodItem.getId(),
                    foodItem.getName(),
                    entry.getValue(),
                    foodItem.getPrice()
            );
            orderItems.add(orderItem);
            total = total.add(foodItem.getPrice()
                    .multiply(BigDecimal.valueOf(entry.getValue())));
        }

        Order order = new Order();
        order.setUserId(user.getId());
        order.setCustomerName(user.getName());
        order.setCustomerAddress(user.getAddress());
        order.setCustomerPhone(user.getPhone());
        order.setItems(orderItems);
        order.setTotalAmount(total);
        String orderType = orderSummaryService.getOrderType(
                orderSummaryService.createOrderByAmount(total));
        System.out.println("Order type: " + orderType);

        order.setStatus(OrderStatus.PENDING);

        return orderRepository.save(order);
    }

    // ==================== After Payment Success ====================

    public Order confirmOrderAfterPayment(Long orderId, String paymentMethod) {
        Order order = getOrderById(orderId);
        order.setStatus(OrderStatus.PAYMENT_SUCCESS);
        order.setPaymentMethod(paymentMethod);
        return orderRepository.save(order);
    }

    // ==================== Get Orders ====================

    public Order getOrderById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found!"));
    }

    public List<Order> getOrdersByUser(String email) {
        User user = userService.getUserByEmail(email);
        return orderRepository.findByUserIdOrderByCreatedAtDesc(user.getId());
    }

    public List<Order> getActiveOrders(String email) {
        User user = userService.getUserByEmail(email);
        List<Order> orders = orderRepository
                .findByUserIdOrderByCreatedAtDesc(user.getId());
        orders.removeIf(o -> o.getStatus() == OrderStatus.DELIVERED
                || o.getStatus() == OrderStatus.DECLINED);
        return orders;
    }

    // ==================== Cancel Order ====================

    public Order cancelOrder(Long orderId, String customerEmail) {
        Order order = getOrderById(orderId);
        User user = userService.getUserByEmail(customerEmail);

        if (!order.getUserId().equals(user.getId())) {
            throw new RuntimeException("Unauthorized!");
        }

        if (order.getStatus() != OrderStatus.PENDING
                && order.getStatus() != OrderStatus.PAYMENT_SUCCESS) {
            throw new RuntimeException(
                    "Order cannot be cancelled after restaurant accepts it!");
        }

        order.setStatus(OrderStatus.DECLINED);
        return orderRepository.save(order);
    }

    // ==================== Calculate Total ====================

    public BigDecimal calculateTotal(Map<Long, Integer> cartItems) {
        BigDecimal total = BigDecimal.ZERO;
        for (Map.Entry<Long, Integer> entry : cartItems.entrySet()) {
            FoodItem foodItem = foodItemRepository.findById(entry.getKey())
                    .orElseThrow(() -> new RuntimeException("Food item not found!"));
            total = total.add(foodItem.getPrice()
                    .multiply(BigDecimal.valueOf(entry.getValue())));
        }
        return total;
    }
}