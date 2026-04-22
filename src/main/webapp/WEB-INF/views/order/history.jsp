<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order History</title>
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
    <a href="/order/cart"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      🛒 Cart
    </a>
    <a href="/user/logout"
       class="bg-orange-800 px-4 py-2 rounded-lg font-semibold hover:bg-orange-900">
      Logout
    </a>
  </div>
</nav>

<div class="max-w-4xl mx-auto px-6 py-10">
  <h2 class="text-3xl font-bold text-gray-800 mb-8">My Orders</h2>

  <!-- Success/Error -->
  <c:if test="${not empty success}">
    <div class="bg-green-100 text-green-800 px-4 py-3 rounded-xl mb-6">
        ${success}
    </div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="bg-red-100 text-red-800 px-4 py-3 rounded-xl mb-6">
        ${error}
    </div>
  </c:if>

  <c:choose>
    <c:when test="${empty orders}">
      <div class="bg-white rounded-2xl shadow p-12 text-center">
        <p class="text-6xl mb-4">📦</p>
        <p class="text-gray-500 text-lg mb-6">No orders yet!</p>
        <a href="/order/menu"
           class="bg-orange-600 text-white px-6 py-3 rounded-xl
                              font-semibold hover:bg-orange-700">
          Order Now
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="space-y-4">
        <c:forEach var="order" items="${orders}">
          <div class="bg-white rounded-2xl shadow p-6">
            <div class="flex justify-between items-start mb-4">
              <div>
                <h3 class="font-bold text-gray-800 text-lg">
                  Order #${order.id}
                </h3>
                <p class="text-sm text-gray-500">
                    ${order.createdAt}
                </p>
              </div>
              <div class="text-right">
                <p class="font-bold text-orange-600 text-lg">
                  Rs. ${order.totalAmount}
                </p>
                <!-- Status Badge -->
                <c:choose>
                  <c:when test="${order.status == 'PENDING'}">
                                            <span class="bg-yellow-100 text-yellow-700
                                                         text-xs px-2 py-1 rounded-full">
                                                ⏳ Pending Payment
                                            </span>
                  </c:when>
                  <c:when test="${order.status == 'PAYMENT_SUCCESS'}">
                                            <span class="bg-blue-100 text-blue-700
                                                         text-xs px-2 py-1 rounded-full">
                                                📨 Sent to Restaurant
                                            </span>
                  </c:when>
                  <c:when test="${order.status == 'ACCEPTED'}">
                                            <span class="bg-green-100 text-green-700
                                                         text-xs px-2 py-1 rounded-full">
                                                ✅ Accepted
                                            </span>
                  </c:when>
                  <c:when test="${order.status == 'PREPARING'}">
                                            <span class="bg-orange-100 text-orange-700
                                                         text-xs px-2 py-1 rounded-full">
                                                👨‍🍳 Preparing
                                            </span>
                  </c:when>
                  <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                            <span class="bg-purple-100 text-purple-700
                                                         text-xs px-2 py-1 rounded-full">
                                                🚚 Out for Delivery
                                            </span>
                  </c:when>
                  <c:when test="${order.status == 'DELIVERED'}">
                                            <span class="bg-green-100 text-green-700
                                                         text-xs px-2 py-1 rounded-full">
                                                ✅ Delivered
                                            </span>
                  </c:when>
                  <c:when test="${order.status == 'DECLINED'}">
                                            <span class="bg-red-100 text-red-700
                                                         text-xs px-2 py-1 rounded-full">
                                                ❌ Cancelled
                                            </span>
                  </c:when>
                </c:choose>
              </div>
            </div>

            <!-- Order Items -->
            <div class="mb-4">
              <c:forEach var="item" items="${order.items}">
                <p class="text-sm text-gray-600">
                  • ${item.foodItemName} x${item.quantity}
                  — Rs. ${item.price}
                </p>
              </c:forEach>
            </div>

            <!-- Actions -->
            <div class="flex gap-3">
              <a href="/order/details/${order.id}"
                 class="bg-blue-500 text-white px-4 py-2
                                          rounded-lg text-sm font-semibold
                                          hover:bg-blue-600">
                View Details
              </a>
              <c:if test="${order.status == 'PENDING' or
                                              order.status == 'PAYMENT_SUCCESS'}">
                <form action="/order/cancel/${order.id}"
                      method="post"
                      onsubmit="return confirm('Cancel this order?')">
                  <button type="submit"
                          class="bg-red-500 text-white px-4 py-2
                                                       rounded-lg text-sm font-semibold
                                                       hover:bg-red-600">
                    Cancel Order
                  </button>
                </form>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>