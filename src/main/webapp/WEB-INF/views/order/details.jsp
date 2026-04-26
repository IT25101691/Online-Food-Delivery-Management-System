<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Details</title>
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

<div class="max-w-2xl mx-auto px-6 py-10">

  <div class="bg-white rounded-2xl shadow p-8">
    <div class="flex justify-between items-start mb-6">
      <div>
        <h2 class="text-2xl font-bold text-gray-800">
          Order #${order.id}
        </h2>
        <p class="text-gray-500 text-sm">${order.createdAt}</p>
      </div>
      <!-- Status Badge -->
      <c:choose>
        <c:when test="${order.status == 'PENDING'}">
                        <span class="bg-yellow-100 text-yellow-700
                                     px-3 py-1 rounded-full text-sm font-semibold">
                            ⏳ Pending Payment
                        </span>
        </c:when>
        <c:when test="${order.status == 'PAYMENT_SUCCESS'}">
                        <span class="bg-blue-100 text-blue-700
                                     px-3 py-1 rounded-full text-sm font-semibold">
                            📨 Sent to Restaurant
                        </span>
        </c:when>
        <c:when test="${order.status == 'ACCEPTED'}">
                        <span class="bg-green-100 text-green-700
                                     px-3 py-1 rounded-full text-sm font-semibold">
                            ✅ Accepted
                        </span>
        </c:when>
        <c:when test="${order.status == 'PREPARING'}">
                        <span class="bg-orange-100 text-orange-700
                                     px-3 py-1 rounded-full text-sm font-semibold">
                            👨‍🍳 Preparing
                        </span>
        </c:when>
        <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                        <span class="bg-purple-100 text-purple-700
                                     px-3 py-1 rounded-full text-sm font-semibold">
                            🚚 Out for Delivery
                        </span>
        </c:when>
        <c:when test="${order.status == 'DELIVERED'}">
                        <span class="bg-green-100 text-green-700
                                     px-3 py-1 rounded-full text-sm font-semibold">
                            ✅ Delivered
                        </span>
        </c:when>
        <c:when test="${order.status == 'DECLINED'}">
                        <span class="bg-red-100 text-red-700
                                     px-3 py-1 rounded-full text-sm font-semibold">
                            ❌ Cancelled
                        </span>
        </c:when>
      </c:choose>
    </div>

    <!-- Customer Details -->
    <div class="bg-gray-50 rounded-xl p-4 mb-6">
      <h3 class="font-bold text-gray-700 mb-3">Delivery Details</h3>
      <p class="text-sm text-gray-600">👤 ${order.customerName}</p>
      <p class="text-sm text-gray-600">📞 ${order.customerPhone}</p>
      <p class="text-sm text-gray-600">📍 ${order.customerAddress}</p>
      <p class="text-sm text-gray-600">💳 ${order.paymentMethod}</p>
    </div>

    <!-- Order Items -->
    <div class="mb-6">
      <h3 class="font-bold text-gray-700 mb-3">Items Ordered</h3>
      <div class="space-y-2">
        <c:forEach var="item" items="${order.items}">
          <div class="flex justify-between text-sm">
                            <span class="text-gray-600">
                                ${item.foodItemName} x${item.quantity}
                            </span>
            <span class="font-semibold text-gray-800">
                                Rs. ${item.price}
                            </span>
          </div>
        </c:forEach>
      </div>
      <div class="border-t mt-3 pt-3 flex justify-between font-bold">
        <span>Total</span>
        <span class="text-orange-600">Rs. ${order.totalAmount}</span>
      </div>
    </div>

    <!-- Actions -->
    <div class="flex gap-3">
      <a href="/order/history"
         class="bg-gray-200 text-gray-700 px-6 py-2 rounded-xl
                          font-semibold hover:bg-gray-300">
        ← Back
      </a>
      <c:if test="${order.status == 'PENDING' or
                              order.status == 'PAYMENT_SUCCESS'}">
        <form action="/order/cancel/${order.id}"
              method="post"
              onsubmit="return confirm('Cancel this order?')">
          <button type="submit"
                  class="bg-red-500 text-white px-6 py-2
                                       rounded-xl font-semibold hover:bg-red-600">
            Cancel Order
          </button>
        </form>
      </c:if>
    </div>
  </div>
</div>
</body>
</html>