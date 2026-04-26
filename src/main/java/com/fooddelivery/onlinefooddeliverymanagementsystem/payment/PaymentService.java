package com.fooddelivery.onlinefooddeliverymanagementsystem.payment;

import com.fooddelivery.onlinefooddeliverymanagementsystem.order.Order;
import com.fooddelivery.onlinefooddeliverymanagementsystem.order.OrderService;
import com.fooddelivery.onlinefooddeliverymanagementsystem.user.User;
import com.fooddelivery.onlinefooddeliverymanagementsystem.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Lazy
    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    // ==================== Process Payment ====================

    public Payment processPayment(Long orderId, String customerEmail,
                                  Payment.PaymentMethod method) {

        User user = userService.getUserByEmail(customerEmail);
        Order order = orderService.getOrderById(orderId);

        // Cash validation — must be under 2500 Rs
        if (method == Payment.PaymentMethod.CASH) {
            if (order.getTotalAmount()
                    .compareTo(new BigDecimal("2500")) > 0) {
                throw new RuntimeException(
                        "Cash payment is only allowed for orders under Rs. 2500!");
            }
        }

        // Create payment record
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setUserId(user.getId());
        payment.setAmount(order.getTotalAmount());
        payment.setPaymentMethod(method);
        payment.setStatus(Payment.PaymentStatus.SUCCESS);
        paymentRepository.save(payment);

        // Confirm order after payment
        orderService.confirmOrderAfterPayment(orderId, method.name());

        return payment;
    }

    // ==================== Get Payment ====================

    public Payment getPaymentByOrderId(Long orderId) {
        return paymentRepository.findByOrderId(orderId)
                .orElseThrow(() -> new RuntimeException("Payment not found!"));
    }

    public List<Payment> getPaymentsByUser(String email) {
        User user = userService.getUserByEmail(email);
        return paymentRepository.findByUserId(user.getId());
    }

    // ==================== Validate Card (Fake) ====================

    public boolean validateCard(String cardNumber,
                                String expiryDate, String cvv) {
        // Check card number - must be 16 digits
        if (cardNumber == null || cardNumber.replaceAll("\\s", "").length() != 16) {
            return false;
        }

        // Check CVV - must be 3 digits
        if (cvv == null || cvv.length() != 3) {
            return false;
        }

        // Check expiry format MM/YY
        if (expiryDate == null || !expiryDate.matches("\\d{2}/\\d{2}")) {
            return false;
        }

        // Check expiry date is not in the past
        try {
            String[] parts = expiryDate.split("/");
            int month = Integer.parseInt(parts[0]);
            int year = Integer.parseInt(parts[1]) + 2000;

            // Month must be 1-12
            if (month < 1 || month > 12) {
                return false;
            }

            java.time.YearMonth cardExpiry = java.time.YearMonth.of(year, month);
            java.time.YearMonth now = java.time.YearMonth.now();

            if (cardExpiry.isBefore(now)) {
                return false;
            }
        } catch (Exception e) {
            return false;
        }

        return true;
    }
}