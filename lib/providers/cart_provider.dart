import 'package:flutter/material.dart'; 
import 'package:e_commerce/model/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
  
 
  final List<Map<String, dynamic>> _notifications = [];
  List<Map<String, dynamic>> get notifications => _notifications;

  Map<String, CartItem> get cartItems => _cartItems;

 

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity++;
    } else {
      _cartItems[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void incrementQuantity(String id) {
    if (_cartItems.containsKey(id)) {
      _cartItems[id]!.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String id) {
    if (_cartItems.containsKey(id)) {
      if (_cartItems[id]!.quantity > 1) {
        _cartItems[id]!.quantity--;
      } else {
        _cartItems.remove(id);
      }
      notifyListeners();
    }
  }

  int get itemCount {
    int total = 0;
    _cartItems.forEach((key, item) => total += item.quantity);
    return total;
  }

  double get totalPrice {
    double total = 0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }


  void addNotification({
    required String title, 
    required String message, 
    required IconData icon, 
  }) {
    _notifications.insert(0, {
      'icon': icon,
      'title': title,
      'message': message,
      'time': 'JUST NOW',
      'unread': true,
    });
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  
  void markAsRead(int index) {
    if (index < _notifications.length) {
      _notifications[index]['unread'] = false;
      notifyListeners();
    }
  }
}