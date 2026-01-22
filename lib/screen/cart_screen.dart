import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screen/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.cartItems.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart (${cart.itemCount})'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MessageScreen()),
              );
            },
            icon: const Icon(Icons.message_outlined),
          ),
        ],
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: items.isEmpty
          ? const Center(child: Text('No items in cart'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final product = item.product;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Image.asset(product.image, width: 80),
                          title: Text(product.name),
                          subtitle: Text(
                            '₱${product.price.toStringAsFixed(2)} x ${item.quantity}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cart.decrementQuantity(product.id);
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 20,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Text('${item.quantity}')),
                              ),
                              IconButton(
                                onPressed: () {
                                  cart.incrementQuantity(product.id);
                                },
                                icon: const Icon(Icons.add_circle_outline, size: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ₱${cart.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              onPressed: cart.cartItems.isEmpty
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          title: const Column(
                            children: [
                              Icon(Icons.check_circle_outline, color: Colors.white, size: 50),
                              SizedBox(height: 15),
                              Text(
                                'ORDER CONFIRMED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          content: const Text(
                            'IMPOSSIBLE IS NOTHING.\n\nThank you for choosing our Shop. Your Shoes is being prepared for greatness.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          actions: [
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  cart.addNotification(
                                    title: 'GEAR CONFIRMED',
                                    message: 'Your order has been placed. We are preparing your Shoes',
                                    icon: Icons.inventory_2_outlined,
                                  );

                                  cart.clearCart();
                                  
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Thank You!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
              child: const Text(
                'CHECKOUT',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
