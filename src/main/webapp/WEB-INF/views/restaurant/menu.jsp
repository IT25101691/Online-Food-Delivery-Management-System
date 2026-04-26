<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Menu Management</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<!-- Navbar -->
<nav class="bg-orange-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
  <h1 class="text-2xl font-bold">🍽️ Menu Management</h1>
  <div class="flex gap-4">
    <a href="/restaurant/dashboard"
       class="bg-white text-orange-600 px-4 py-2 rounded-lg font-semibold hover:bg-orange-50">
      Dashboard
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

<div class="max-w-6xl mx-auto px-6 py-10">

  <!-- Success/Error Messages -->
  <c:if test="${not empty success}">
    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl mb-6">
        ${success}
    </div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl mb-6">
        ${error}
    </div>
  </c:if>

  <!-- Add Food Item Form -->
  <div class="bg-white rounded-2xl shadow p-6 mb-10">
    <h2 class="text-xl font-bold text-gray-800 mb-6">Add New Food Item</h2>
    <form action="/restaurant/menu/add" method="post" enctype="multipart/form-data">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Food Name</label>
          <input type="text" name="name" required
                 class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400"
                 placeholder="e.g. Chicken Burger"/>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
          <select name="category"
                  class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400">
            <option value="Burgers">Burgers</option>
            <option value="Pizza">Pizza</option>
            <option value="Rice">Rice</option>
            <option value="Noodles">Noodles</option>
            <option value="Desserts">Desserts</option>
            <option value="Drinks">Drinks</option>
            <option value="Sides">Sides</option>
            <option value="Other">Other</option>
          </select>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Price (Rs.)</label>
          <input type="number" name="price" step="0.01" required
                 class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400"
                 placeholder="e.g. 450.00"/>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Food Image</label>
          <input type="file" name="image" accept="image/*"
                 class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400"/>
        </div>

        <div class="md:col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
          <textarea name="description" required rows="3"
                    class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400"
                    placeholder="Describe the food item..."></textarea>
        </div>

      </div>
      <button type="submit"
              class="mt-4 bg-orange-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-orange-700">
        + Add Food Item
      </button>
    </form>
  </div>

  <!-- Food Items List -->
  <div class="bg-white rounded-2xl shadow p-6">
    <h2 class="text-xl font-bold text-gray-800 mb-6">Menu Items</h2>

    <c:choose>
      <c:when test="${empty foodItems}">
        <p class="text-gray-500 text-center py-10">No food items yet. Add your first item above!</p>
      </c:when>
      <c:otherwise>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <c:forEach var="item" items="${foodItems}">
            <div class="border border-gray-200 rounded-2xl overflow-hidden hover:shadow-md transition">

              <!-- Food Image -->
              <c:choose>
                <c:when test="${not empty item.imageUrl}">
                  <img src="${item.imageUrl}" alt="${item.name}"
                       class="w-full h-48 object-cover"/>
                </c:when>
                <c:otherwise>
                  <div class="w-full h-48 bg-gray-200 flex items-center justify-center">
                    <span class="text-gray-400 text-4xl">🍽️</span>
                  </div>
                </c:otherwise>
              </c:choose>

              <div class="p-4">
                <div class="flex justify-between items-start mb-2">
                  <h3 class="font-bold text-gray-800">${item.name}</h3>
                  <span class="text-orange-600 font-bold">Rs. ${item.price}</span>
                </div>
                <p class="text-gray-500 text-sm mb-2">${item.description}</p>
                <span class="bg-orange-100 text-orange-600 text-xs px-2 py-1 rounded-full">
                    ${item.category}
                </span>

                <!-- Availability Badge -->
                <div class="mt-2">
                  <c:choose>
                    <c:when test="${item.available}">
                                                <span class="bg-green-100 text-green-600 text-xs px-2 py-1 rounded-full">
                                                    ✅ Available
                                                </span>
                    </c:when>
                    <c:otherwise>
                                                <span class="bg-red-100 text-red-600 text-xs px-2 py-1 rounded-full">
                                                    ❌ Unavailable
                                                </span>
                    </c:otherwise>
                  </c:choose>
                </div>

                <!-- Action Buttons -->
                <div class="flex gap-2 mt-4">
                  <a href="/restaurant/menu/edit/${item.id}"
                     class="flex-1 text-center bg-blue-500 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:bg-blue-600">
                    Edit
                  </a>
                  <form action="/restaurant/menu/toggle/${item.id}" method="post" class="flex-1">
                    <button type="submit"
                            class="w-full bg-yellow-500 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:bg-yellow-600">
                      Toggle
                    </button>
                  </form>
                  <form action="/restaurant/menu/delete/${item.id}" method="post"
                        onsubmit="return confirm('Are you sure you want to delete this item?')">
                    <button type="submit"
                            class="bg-red-500 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:bg-red-600">
                      Delete
                    </button>
                  </form>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

</body>
</html>