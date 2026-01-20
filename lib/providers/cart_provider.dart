import 'package:e_commerce/model/product.dart';
import 'package:flutter/foundation.dart';


class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {

  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => _cartItems;

  // Add to cart function
  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity++;
    } else {
      _cartItems[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  // Remove to cart function
  void removeFromCart(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  // Increment the quantity of an item
  void incrementQuantity(String id) {
    if (_cartItems.containsKey(id)) {
      _cartItems[id]!.quantity++;
      notifyListeners();
    }
  }

  // Decrement the quantity of an item
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

  // count how many items are in the cart
  int get itemCount {
    int total = 0;
    _cartItems.forEach((key, item) => total += item.quantity);
    return total;
  }

  // Sum up all product prices
  double get totalPrice {
    double total = 0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // Clear items in the cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
