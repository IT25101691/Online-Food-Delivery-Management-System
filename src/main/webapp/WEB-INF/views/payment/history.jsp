<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Payment History</title>
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
      Orders
    </a>
    <a href="/user/logout"
       class="bg-orange-800 px-4 py-2 rounded-lg font-semibold hover:bg-orange-900">
      Logout
    </a>
  </div>
</nav>

<div class="max-w-4xl mx-auto px-6 py-10">
  <h2 class="text-3xl font-bold text-gray-800 mb-8">Payment History</h2>

  <c:choose>
    <c:when test="${empty payments}">
      <div class="bg-white rounded-2xl shadow p-12 text-center">
        <p class="text-5xl mb-4">💳</p>
        <p class="text-gray-500 text-lg">No payments yet</p>
      </div>
    </c:when>
    <c:otherwise>
      <div class="space-y-4">
        <c:forEach var="payment" items="${payments}">
          <div class="bg-white rounded-2xl shadow p-6 flex
                                    justify-between items-center">
            <div>
              <p class="font-bold text-gray-800">
                Order #${payment.orderId}
              </p>
              <p class="text-sm text-gray-500">
                  ${payment.paymentMethod} —
                  ${payment.createdAt}
              </p>
            </div>
            <div class="text-right">
              <p class="font-bold text-orange-600 text-lg">
                Rs. ${payment.amount}
              </p>
              <span class="bg-green-100 text-green-700
                                             text-xs px-2 py-1 rounded-full">
                  ${payment.status}
              </span>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>