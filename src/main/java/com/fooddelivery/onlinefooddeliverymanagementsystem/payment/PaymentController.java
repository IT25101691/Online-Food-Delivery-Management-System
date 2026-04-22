package com.fooddelivery.onlinefooddeliverymanagementsystem.payment;

import com.fooddelivery.onlinefooddeliverymanagementsystem.order.Order;
import com.fooddelivery.onlinefooddeliverymanagementsystem.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private OrderService orderService;

    // ==================== Payment Page ====================

    @GetMapping("/pay")
    public String paymentPage(
            @RequestParam Long orderId,
            Principal principal,
            Model model) {
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        return "payment/pay";
    }

    // ==================== Process Cash Payment ====================

    @PostMapping("/cash")
    public String processCash(
            @RequestParam Long orderId,
            Principal principal,
            RedirectAttributes redirectAttributes) {
        try {
            paymentService.processPayment(
                    orderId,
                    principal.getName(),
                    Payment.PaymentMethod.CASH);
            return "redirect:/order/success?orderId=" + orderId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/payment/pay?orderId=" + orderId;
        }
    }

    // ==================== Card Payment Page ====================

    @GetMapping("/card")
    public String cardPage(
            @RequestParam Long orderId,
            Model model) {
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        return "payment/card";
    }

    // ==================== Process Card Payment ====================

    @PostMapping("/card")
    public String processCard(
            @RequestParam Long orderId,
            @RequestParam String cardNumber,
            @RequestParam String expiryDate,
            @RequestParam String cvv,
            Principal principal,
            RedirectAttributes redirectAttributes) {

        // Validate card details
        if (!paymentService.validateCard(cardNumber, expiryDate, cvv)) {
            redirectAttributes.addFlashAttribute("error",
                    "Invalid card details. Please check and try again!");
            return "redirect:/payment/card?orderId=" + orderId;
        }

        try {
            paymentService.processPayment(
                    orderId,
                    principal.getName(),
                    Payment.PaymentMethod.CARD);
            return "redirect:/order/success?orderId=" + orderId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/payment/card?orderId=" + orderId;
        }
    }

    // ==================== Payment History ====================

    @GetMapping("/history")
    public String paymentHistory(Principal principal, Model model) {
        model.addAttribute("payments",
                paymentService.getPaymentsByUser(principal.getName()));
        return "payment/history";
    }
}