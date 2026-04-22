<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Card Payment</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<nav class="bg-orange-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
  <h1 class="text-2xl font-bold">🍔 Food Delivery</h1>
  <a href="/user/logout"
     class="bg-orange-800 px-4 py-2 rounded-lg font-semibold hover:bg-orange-900">
    Logout
  </a>
</nav>

<div class="max-w-lg mx-auto px-6 py-10">

  <c:if test="${not empty error}">
    <div class="bg-red-100 text-red-800 px-4 py-3 rounded-xl mb-6">
        ${error}
    </div>
  </c:if>

  <div class="bg-white rounded-2xl shadow p-8">
    <h2 class="text-2xl font-bold text-gray-800 mb-2">Card Payment</h2>
    <p class="text-gray-500 mb-6">
      Total: <span class="text-orange-600 font-bold">Rs. ${order.totalAmount}</span>
    </p>

    <form action="/payment/card" method="post">
      <input type="hidden" name="orderId" value="${order.id}"/>

      <div class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Card Number
          </label>
          <input type="text" name="cardNumber"
                 placeholder="1234 5678 9012 3456"
                 maxlength="19" required
                 class="w-full border border-gray-300 rounded-xl px-4 py-3
                                      focus:outline-none focus:ring-2 focus:ring-orange-400
                                      tracking-widest text-lg"/>
        </div>

        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">
              Expiry Date
            </label>
            <input type="text" name="expiryDate"
                   placeholder="MM/YY" maxlength="5" required
                   class="w-full border border-gray-300 rounded-xl px-4 py-3
                                          focus:outline-none focus:ring-2 focus:ring-orange-400"/>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">
              CVV
            </label>
            <input type="password" name="cvv"
                   placeholder="123" maxlength="3" required
                   class="w-full border border-gray-300 rounded-xl px-4 py-3
                                          focus:outline-none focus:ring-2 focus:ring-orange-400"/>
          </div>
        </div>
      </div>

      <button type="submit"
              class="mt-6 w-full bg-blue-600 text-white py-3 rounded-xl
                               font-bold text-lg hover:bg-blue-700">
        Pay Rs. ${order.totalAmount}
      </button>

      <a href="/payment/pay?orderId=${order.id}"
         class="mt-3 block text-center text-gray-500 hover:text-gray-700 text-sm">
        ← Back to payment options
      </a>
    </form>
  </div>
</div>

<script>
  // Auto format card number with spaces
  document.querySelector('input[name="cardNumber"]')
          .addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s/g, '').replace(/\D/g, '');
            let formatted = value.match(/.{1,4}/g)?.join(' ') || value;
            e.target.value = formatted;
          });

  // Auto format expiry date
  document.querySelector('input[name="expiryDate"]')
          .addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
              value = value.substring(0, 2) + '/' + value.substring(2);
            }
            e.target.value = value;
          });
</script>
</body>
</html>