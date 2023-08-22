class PayMobConst {
  static const String paymobBaseUrl = "https://accept.paymob.com/api/";
  static const String paymentApiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2libUZ0WlNJNkltbHVhWFJwWVd3aUxDSndjbTltYVd4bFgzQnJJam8zTURJMU5EQjkuenpjd3hZY2I2ak5rcHlTNENWVnFjdUhxc0F5LU5iYXc2Z2lGZEFpTXdBeGgwSUdmdDJYdGUwN2FOLTZWSEtDdHV1cm1id3pvSHRoUXVkMFJsUDVENXc=";

  static const String getAuthToken = "auth/tokens";
  static const String getOrderId = "ecommerce/orders";
  static const String getPaymentId = "acceptance/payment_keys";
  static const String getRefCode = "acceptance/payments/pay";

  static const String integrationIdKiosk = "4116887";
  static const String integrationIdCard = "3414863";

  static String visaUrl =
      "https://accept.paymob.com/api/acceptance/iframes/734400?payment_token=$finalToken";
  static String paymentAuthToken = "";
  static String paymentOrderId = "";
  static String finalToken = "";
  static String refCode = "";
}
