<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Placed!</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<nav class="bg-orange-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
  <h1 class="text-2xl font-bold">🍔 Food Delivery</h1>
  <div class="flex gap-4">
    <a href="/order/menu"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      Menu
    </a>
    <a href="/order/history"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      My Orders
    </a>
    <a href="/user/logout"
       class="bg-orange-800 px-4 py-2 rounded-lg font-semibold hover:bg-orange-900">
      Logout
    </a>
  </div>
</nav>

<div class="max-w-lg mx-auto px-6 py-16 text-center">

  <div class="bg-white rounded-2xl shadow p-12">
    <!-- Success Icon -->
    <div class="text-8xl mb-6">🎉</div>

    <h2 class="text-3xl font-bold text-gray-800 mb-3">
      Order Placed Successfully!
    </h2>
    <p class="text-gray-500 mb-6">
      Your order has been sent to the restaurant.
      We'll notify you once it's accepted!
    </p>

    <!-- Order Summary -->
    <div class="bg-orange-50 rounded-xl p-4 mb-8 text-left">
      <p class="text-sm font-semibold text-gray-700 mb-2">
        Order Summary
      </p>
      <div class="flex justify-between text-sm text-gray-600 mb-1">
        <span>Order ID</span>
        <span class="font-bold">#${order.id}</span>
      </div>
      <div class="flex justify-between text-sm text-gray-600 mb-1">
        <span>Total Amount</span>
        <span class="font-bold text-orange-600">
                        Rs. ${order.totalAmount}
        </span>
      </div>
      <c:if test="${isBulkOrder}">
        <div class="flex justify-between text-sm text-gray-600 mb-1">
          <span>Order Type</span>
          <span class="font-bold text-purple-600">🎁 Bulk Order</span>
        </div>
        <div class="flex justify-between text-sm text-gray-600 mb-1">
          <span>Discount (10%)</span>
          <span class="font-bold text-green-600">
            - Rs. ${discount}
        </span>
        </div>
        <div class="flex justify-between text-sm font-bold text-gray-800 border-t pt-2">
          <span>Final Total</span>
          <span class="text-green-600">
            Rs. ${finalTotal}
        </span>
        </div>
      </c:if>
      <div class="flex justify-between text-sm text-gray-600 mb-1">
        <span>Payment Method</span>
        <span class="font-bold">${order.paymentMethod}</span>
      </div>
      <div class="flex justify-between text-sm text-gray-600">
        <span>Status</span>
        <span class="font-bold text-blue-600">
                        Sent to Restaurant
                    </span>
      </div>
    </div>

    <!-- Actions -->
    <div class="flex flex-col gap-3">
      <a href="/order/details/${order.id}"
         class="bg-orange-600 text-white px-6 py-3 rounded-xl
                          font-bold hover:bg-orange-700">
        Track My Order
      </a>
      <a href="/order/menu"
         class="bg-gray-100 text-gray-700 px-6 py-3 rounded-xl
                          font-semibold hover:bg-gray-200">
        Order More Food
      </a>
    </div>
  </div>
</div>
</body>
</html>