<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Management</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<!-- Navbar -->
<nav class="bg-orange-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
  <h1 class="text-2xl font-bold">🍽️ Order Management</h1>
  <div class="flex gap-4">
    <a href="/restaurant/dashboard"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      Dashboard
    </a>
    <a href="/restaurant/menu"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      Menu
    </a>
    <a href="/user/logout"
       class="bg-orange-800 px-4 py-2 rounded-lg font-semibold hover:bg-orange-900">
      Logout
    </a>
  </div>
</nav>

<div class="max-w-6xl mx-auto px-6 py-10">

  <!-- Success/Error Messages -->
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

  <!-- Incoming Orders -->
  <div class="bg-white rounded-2xl shadow p-6 mb-8">
    <h2 class="text-xl font-bold text-gray-800 mb-4">
      🔔 Incoming Orders
      <span class="bg-yellow-100 text-yellow-700 text-sm px-2 py-1 rounded-full ml-2">
        ${incomingOrders.size()}
      </span>
    </h2>
    <c:choose>
      <c:when test="${empty incomingOrders}">
        <p class="text-gray-400 text-center py-4">No incoming orders</p>
      </c:when>
      <c:otherwise>
        <div class="space-y-4">
          <c:forEach var="order" items="${incomingOrders}">
            <div class="border border-yellow-200 rounded-xl p-4 bg-yellow-50">
              <div class="flex justify-between items-start mb-3">
                <div>
                  <h3 class="font-bold text-gray-800">
                    Order #${order.id}
                  </h3>
                  <p class="text-sm text-gray-500">
                      ${order.customerName} — ${order.customerPhone}
                  </p>
                  <p class="text-sm text-gray-500">
                    📍 ${order.customerAddress}
                  </p>
                </div>
                <span class="font-bold text-orange-600">
                                        Rs. ${order.totalAmount}
                                    </span>
              </div>

              <!-- Order Items -->
              <div class="mb-3">
                <c:forEach var="item" items="${order.items}">
                  <p class="text-sm text-gray-600">
                    • ${item.foodItemName} x${item.quantity}
                    — Rs. ${item.price}
                  </p>
                </c:forEach>
              </div>

              <!-- Accept/Decline -->
              <div class="flex gap-3">
                <form action="/restaurant/orders/accept/${order.id}"
                      method="post">
                  <button type="submit"
                          class="bg-green-500 text-white px-4 py-2
                                                       rounded-lg text-sm font-semibold
                                                       hover:bg-green-600">
                    ✅ Accept
                  </button>
                </form>
                <form action="/restaurant/orders/decline/${order.id}"
                      method="post">
                  <button type="submit"
                          class="bg-red-500 text-white px-4 py-2
                                                       rounded-lg text-sm font-semibold
                                                       hover:bg-red-600">
                    ❌ Decline
                  </button>
                </form>
                <a href="/restaurant/orders/${order.id}"
                   class="bg-blue-500 text-white px-4 py-2
                                              rounded-lg text-sm font-semibold
                                              hover:bg-blue-600">
                  👁️ View
                </a>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Accepted Orders -->
  <div class="bg-white rounded-2xl shadow p-6 mb-8">
    <h2 class="text-xl font-bold text-gray-800 mb-4">
      ✅ Accepted Orders
      <span class="bg-blue-100 text-blue-700 text-sm px-2 py-1 rounded-full ml-2">
        ${acceptedOrders.size()}
      </span>
    </h2>
    <c:choose>
      <c:when test="${empty acceptedOrders}">
        <p class="text-gray-400 text-center py-4">No accepted orders</p>
      </c:when>
      <c:otherwise>
        <div class="space-y-4">
          <c:forEach var="order" items="${acceptedOrders}">
            <div class="border border-blue-200 rounded-xl p-4 bg-blue-50">
              <div class="flex justify-between items-start mb-3">
                <div>
                  <h3 class="font-bold text-gray-800">
                    Order #${order.id}
                  </h3>
                  <p class="text-sm text-gray-500">
                      ${order.customerName} — ${order.customerPhone}
                  </p>
                </div>
                <span class="font-bold text-orange-600">
                                        Rs. ${order.totalAmount}
                                    </span>
              </div>
              <form action="/restaurant/orders/status/${order.id}"
                    method="post" class="flex gap-3 items-center">
                <select name="status"
                        class="border border-gray-300 rounded-lg px-3 py-2
                                                   text-sm focus:outline-none
                                                   focus:ring-2 focus:ring-orange-400">
                  <option value="PREPARING">Preparing</option>
                  <option value="OUT_FOR_DELIVERY">Out for Delivery</option>
                  <option value="DELIVERED">Delivered</option>
                </select>
                <button type="submit"
                        class="bg-orange-600 text-white px-4 py-2
                                                   rounded-lg text-sm font-semibold
                                                   hover:bg-orange-700">
                  Update Status
                </button>
                <a href="/restaurant/orders/${order.id}"
                   class="bg-blue-500 text-white px-4 py-2
                                              rounded-lg text-sm font-semibold
                                              hover:bg-blue-600">
                  👁️ View
                </a>
              </form>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Preparing Orders -->
  <div class="bg-white rounded-2xl shadow p-6 mb-8">
    <h2 class="text-xl font-bold text-gray-800 mb-4">
      👨‍🍳 Preparing
      <span class="bg-orange-100 text-orange-700 text-sm px-2 py-1 rounded-full ml-2">
        ${preparingOrders.size()}
      </span>
    </h2>
    <c:choose>
      <c:when test="${empty preparingOrders}">
        <p class="text-gray-400 text-center py-4">No orders being prepared</p>
      </c:when>
      <c:otherwise>
        <div class="space-y-4">
          <c:forEach var="order" items="${preparingOrders}">
            <div class="border border-orange-200 rounded-xl p-4 bg-orange-50">
              <div class="flex justify-between items-start mb-3">
                <div>
                  <h3 class="font-bold text-gray-800">
                    Order #${order.id}
                  </h3>
                  <p class="text-sm text-gray-500">
                      ${order.customerName}
                  </p>
                </div>
                <span class="font-bold text-orange-600">
                                        Rs. ${order.totalAmount}
                                    </span>
              </div>
              <form action="/restaurant/orders/status/${order.id}"
                    method="post" class="flex gap-3 items-center">
                <select name="status"
                        class="border border-gray-300 rounded-lg px-3 py-2
                                                   text-sm focus:outline-none
                                                   focus:ring-2 focus:ring-orange-400">
                  <option value="OUT_FOR_DELIVERY">Out for Delivery</option>
                  <option value="DELIVERED">Delivered</option>
                </select>
                <button type="submit"
                        class="bg-orange-600 text-white px-4 py-2
                                                   rounded-lg text-sm font-semibold
                                                   hover:bg-orange-700">
                  Update Status
                </button>
              </form>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Delivered & Declined -->
  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

    <!-- Delivered -->
    <div class="bg-white rounded-2xl shadow p-6">
      <h2 class="text-xl font-bold text-gray-800 mb-4">
        ✅ Delivered
        <span class="bg-green-100 text-green-700 text-sm
                                 px-2 py-1 rounded-full ml-2">
          ${deliveredOrders.size()}
        </span>
      </h2>
      <c:choose>
        <c:when test="${empty deliveredOrders}">
          <p class="text-gray-400 text-center py-4">No delivered orders</p>
        </c:when>
        <c:otherwise>
          <div class="space-y-3">
            <c:forEach var="order" items="${deliveredOrders}">
              <div class="border border-green-200 rounded-xl p-3 bg-green-50">
                <div class="flex justify-between">
                  <div>
                    <p class="font-bold text-gray-800">
                      Order #${order.id}
                    </p>
                    <p class="text-sm text-gray-500">
                        ${order.customerName}
                    </p>
                  </div>
                  <span class="font-bold text-green-600">
                                            Rs. ${order.totalAmount}
                                        </span>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- Declined -->
    <div class="bg-white rounded-2xl shadow p-6">
      <h2 class="text-xl font-bold text-gray-800 mb-4">
        ❌ Declined
        <span class="bg-red-100 text-red-700 text-sm
                                 px-2 py-1 rounded-full ml-2">
          ${declinedOrders.size()}
        </span>
      </h2>
      <c:choose>
        <c:when test="${empty declinedOrders}">
          <p class="text-gray-400 text-center py-4">No declined orders</p>
        </c:when>
        <c:otherwise>
          <div class="space-y-3">
            <c:forEach var="order" items="${declinedOrders}">
              <div class="border border-red-200 rounded-xl p-3 bg-red-50">
                <div class="flex justify-between">
                  <div>
                    <p class="font-bold text-gray-800">
                      Order #${order.id}
                    </p>
                    <p class="text-sm text-gray-500">
                        ${order.customerName}
                    </p>
                  </div>
                  <span class="font-bold text-red-600">
                                            Rs. ${order.totalAmount}
                                        </span>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
</body>
</html>