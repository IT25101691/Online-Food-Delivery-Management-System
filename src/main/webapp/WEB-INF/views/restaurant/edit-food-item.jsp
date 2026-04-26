<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Food Item</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<!-- Navbar -->
<nav class="bg-orange-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
  <h1 class="text-2xl font-bold">🍽️ Edit Food Item</h1>
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

<div class="max-w-2xl mx-auto px-6 py-10">
  <div class="bg-white rounded-2xl shadow p-8">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Edit Food Item</h2>

    <!-- Current Image -->
    <c:if test="${not empty foodItem.imageUrl}">
      <div class="mb-6">
        <p class="text-sm font-medium text-gray-700 mb-2">Current Image</p>
        <img src="${foodItem.imageUrl}" alt="${foodItem.name}"
             class="w-full h-48 object-cover rounded-xl"/>
      </div>
    </c:if>

    <form action="/restaurant/menu/edit/${foodItem.id}"
          method="post" enctype="multipart/form-data">

      <div class="grid grid-cols-1 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Food Name
          </label>
          <input type="text" name="name" value="${foodItem.name}" required
                 class="w-full border border-gray-300 rounded-xl px-4 py-2
                                      focus:outline-none focus:ring-2 focus:ring-orange-400"/>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Category
          </label>
          <select name="category" required
                  class="w-full border border-gray-300 rounded-xl px-4 py-2
                                       focus:outline-none focus:ring-2 focus:ring-orange-400">
            <option value="Burgers"
            ${foodItem.category == 'Burgers' ? 'selected' : ''}>
              Burgers
            </option>
            <option value="Pizza"
            ${foodItem.category == 'Pizza' ? 'selected' : ''}>
              Pizza
            </option>
            <option value="Rice"
            ${foodItem.category == 'Rice' ? 'selected' : ''}>
              Rice
            </option>
            <option value="Noodles"
            ${foodItem.category == 'Noodles' ? 'selected' : ''}>
              Noodles
            </option>
            <option value="Drinks"
            ${foodItem.category == 'Drinks' ? 'selected' : ''}>
              Drinks
            </option>
            <option value="Desserts"
            ${foodItem.category == 'Desserts' ? 'selected' : ''}>
              Desserts
            </option>
            <option value="Sides"
            ${foodItem.category == 'Sides' ? 'selected' : ''}>
              Sides
            </option>
            <option value="Other"
            ${foodItem.category == 'Other' ? 'selected' : ''}>
              Other
            </option>
          </select>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Price (Rs)
          </label>
          <input type="number" name="price" step="0.01"
                 value="${foodItem.price}" required
                 class="w-full border border-gray-300 rounded-xl px-4 py-2
                                      focus:outline-none focus:ring-2 focus:ring-orange-400"/>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Description
          </label>
          <textarea name="description" required rows="3"
                    class="w-full border border-gray-300 rounded-xl px-4 py-2
                                         focus:outline-none focus:ring-2 focus:ring-orange-400">
            ${foodItem.description}
          </textarea>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Update Image (optional)
          </label>
          <input type="file" name="image" accept="image/*"
                 class="w-full border border-gray-300 rounded-xl px-4 py-2
                                      focus:outline-none focus:ring-2 focus:ring-orange-400"/>
          <p class="text-xs text-gray-400 mt-1">
            Leave empty to keep current image
          </p>
        </div>

        <div class="flex items-center gap-2">
          <input type="checkbox" name="available" id="available"
          ${foodItem.available ? 'checked' : ''}
                 class="w-4 h-4 accent-orange-500"/>
          <label for="available" class="text-sm font-medium text-gray-700">
            Available
          </label>
        </div>
      </div>

      <div class="flex gap-4 mt-6">
        <button type="submit"
                class="bg-orange-600 text-white px-6 py-2 rounded-xl
                                   font-semibold hover:bg-orange-700">
          Save Changes
        </button>
        <a href="/restaurant/menu"
           class="bg-gray-200 text-gray-700 px-6 py-2 rounded-xl
                              font-semibold hover:bg-gray-300">
          Cancel
        </a>
      </div>
    </form>
  </div>
</div>
</body>
</html>