<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Restaurant Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<!-- Navbar -->
<nav class="bg-orange-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
  <h1 class="text-2xl font-bold">🍽️ Restaurant Panel</h1>
  <div class="flex gap-4">
    <a href="/restaurant/menu"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      Menu
    </a>
    <a href="/restaurant/orders"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      Orders
    </a>
    <a href="/user/logout"
       class="bg-orange-800 px-4 py-2 rounded-lg font-semibold hover:bg-orange-900">
      Logout
    </a>
  </div>
</nav>

<!-- Main Content -->
<div class="max-w-6xl mx-auto px-6 py-10">

  <h2 class="text-3xl font-bold text-gray-800 mb-8">Dashboard Overview</h2>

  <!-- Stats Cards -->
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">

    <div class="bg-white rounded-2xl shadow p-6 border-l-4 border-orange-500">
      <p class="text-gray-500 text-sm">Total Menu Items</p>
      <h3 class="text-4xl font-bold text-orange-600 mt-2">${totalItems}</h3>
    </div>

    <div class="bg-white rounded-2xl shadow p-6 border-l-4 border-yellow-500">
      <p class="text-gray-500 text-sm">Incoming Orders</p>
      <h3 class="text-4xl font-bold text-yellow-600 mt-2">${incomingOrders}</h3>
    </div>

    <div class="bg-white rounded-2xl shadow p-6 border-l-4 border-blue-500">
      <p class="text-gray-500 text-sm">Accepted Orders</p>
      <h3 class="text-4xl font-bold text-blue-600 mt-2">${acceptedOrders}</h3>
    </div>

    <div class="bg-white rounded-2xl shadow p-6 border-l-4 border-green-500">
      <p class="text-gray-500 text-sm">Preparing</p>
      <h3 class="text-4xl font-bold text-green-600 mt-2">${preparingOrders}</h3>
    </div>

  </div>

  <!-- Quick Actions -->
  <div class="bg-white rounded-2xl shadow p-6">
    <h3 class="text-xl font-bold text-gray-800 mb-4">Quick Actions</h3>
    <div class="flex flex-wrap gap-4">
      <a href="/restaurant/menu"
         class="bg-orange-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-orange-700">
        🍔 Manage Menu
      </a>
      <a href="/restaurant/orders"
         class="bg-yellow-500 text-white px-6 py-3 rounded-xl font-semibold hover:bg-yellow-600">
        📦 View Orders
      </a>
    </div>
  </div>

</div>

</body>
</html>