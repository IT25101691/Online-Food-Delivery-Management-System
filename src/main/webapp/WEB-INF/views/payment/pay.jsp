<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Payment</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<!-- Navbar -->
<nav class="bg-orange-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
  <h1 class="text-2xl font-bold">🍔 Food Delivery</h1>
  <a href="/user/logout"
     class="bg-orange-800 px-4 py-2 rounded-lg font-semibold hover:bg-orange-900">
    Logout
  </a>
</nav>

<div class="max-w-2xl mx-auto px-6 py-10">

  <!-- Error Message -->
  <c:if test="${not empty error}">
    <div class="bg-red-100 text-red-800 px-4 py-3 rounded-xl mb-6">
        ${error}
    </div>
  </c:if>

  <!-- Order Summary -->
  <div class="bg-white rounded-2xl shadow p-6 mb-6">
    <h2 class="text-xl font-bold text-gray-800 mb-4">Order Summary</h2>
    <div class="space-y-2 mb-4">
      <c:forEach var="item" items="${order.items}">
        <div class="flex justify-between text-sm text-gray-600">
          <span>${item.foodItemName} x${item.quantity}</span>
          <span>Rs. ${item.price}</span>
        </div>
      </c:forEach>
    </div>
    <div class="border-t pt-3 flex justify-between font-bold text-gray-800">
      <span>Total</span>
      <span class="text-orange-600">Rs. ${order.totalAmount}</span>
    </div>
  </div>

  <!-- Payment Options -->
  <div class="bg-white rounded-2xl shadow p-6">
    <h2 class="text-xl font-bold text-gray-800 mb-6">
      Select Payment Method
    </h2>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

      <!-- Cash Option -->
      <div class="border-2 border-gray-200 rounded-2xl p-6 text-center
                            hover:border-orange-400 transition-all">
        <div class="text-5xl mb-3">💵</div>
        <h3 class="font-bold text-gray-800 text-lg mb-2">Cash on Delivery</h3>
        <p class="text-gray-500 text-sm mb-4">
          Only available for orders under Rs. 2500
        </p>
        <c:choose>
          <c:when test="${order.totalAmount > 2500}">
            <p class="text-red-500 text-sm font-semibold">
              ❌ Not available for this order
            </p>
          </c:when>
          <c:otherwise>
            <form action="/payment/cash" method="post">
              <input type="hidden" name="orderId" value="${order.id}"/>
              <button type="submit"
                      class="bg-orange-600 text-white px-6 py-2
                                               rounded-xl font-semibold hover:bg-orange-700
                                               w-full">
                Pay with Cash
              </button>
            </form>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Card Option -->
      <div class="border-2 border-gray-200 rounded-2xl p-6 text-center
                            hover:border-orange-400 transition-all">
        <div class="text-5xl mb-3">💳</div>
        <h3 class="font-bold text-gray-800 text-lg mb-2">Card Payment</h3>
        <p class="text-gray-500 text-sm mb-4">
          Pay securely with your credit or debit card
        </p>
        <a href="/payment/card?orderId=${order.id}"
           class="bg-blue-600 text-white px-6 py-2 rounded-xl
                              font-semibold hover:bg-blue-700 block w-full">
          Pay with Card
        </a>
      </div>
    </div>
  </div>
</div>
</body>
</html>