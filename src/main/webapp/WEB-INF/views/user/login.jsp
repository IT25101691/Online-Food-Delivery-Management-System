<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<div class="bg-white rounded-2xl shadow-lg p-10 w-full max-w-md">

  <div class="text-center mb-8">
    <p class="text-5xl mb-3">🍔</p>
    <h1 class="text-3xl font-bold text-gray-800">Food Delivery</h1>
    <p class="text-gray-500 mt-1">Sign in to your account</p>
  </div>

  <!-- Error Message -->
  <c:if test="${param.error != null}">
    <div class="bg-red-100 text-red-800 px-4 py-3 rounded-xl mb-6">
      ❌ Invalid email or password. Please try again.
    </div>
  </c:if>

  <!-- Logout Message -->
  <c:if test="${param.logout != null}">
    <div class="bg-green-100 text-green-800 px-4 py-3 rounded-xl mb-6">
      ✅ You have been logged out successfully.
    </div>
  </c:if>

  <form action="/user/login/process" method="post">
    <div class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Email
        </label>
        <input type="email" name="username" required
               placeholder="Enter your email"
               class="w-full border border-gray-300 rounded-xl px-4 py-3
                                  focus:outline-none focus:ring-2 focus:ring-orange-400"/>
      </div>
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Password
        </label>
        <input type="password" name="password" required
               placeholder="Enter your password"
               class="w-full border border-gray-300 rounded-xl px-4 py-3
                                  focus:outline-none focus:ring-2 focus:ring-orange-400"/>
      </div>
    </div>

    <button type="submit"
            class="mt-6 w-full bg-orange-600 text-white py-3 rounded-xl
                           font-bold text-lg hover:bg-orange-700">
      Sign In
    </button>
  </form>

  <!-- Test Accounts -->
  <div class="mt-8 bg-gray-50 rounded-xl p-4">
    <p class="text-xs font-semibold text-gray-500 mb-2">
      TEST ACCOUNTS
    </p>
    <p class="text-xs text-gray-600">
      👤 Customer: customer@test.com / test1234
    </p>
    <p class="text-xs text-gray-600">
      🍽️ Restaurant: restaurant@test.com / test1234
    </p>
    <p class="text-xs text-gray-600">
      🛠️ Admin: admin123@gmail.com / Admin@1234
    </p>
  </div>
</div>
</body>
</html>