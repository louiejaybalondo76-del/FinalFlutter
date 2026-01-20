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
                MaterialPageRoute(builder: (_) => MessageScreen()),
              );
            },
            icon: Icon(Icons.message_outlined),
          ),
        ],
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
      ),
      body: items.isEmpty
          ? Center(child: Text('No items in cart'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final product = item.product;

                // return ListTile(
                //   title: Text(product.name),
                //   subtitle: Text(
                //     '₱${product.price.toStringAsFixed(2)} x ${item.quantity}',
                //   ),
                //   trailing: IconButton(
                //     onPressed: () => cart.removeFromCart(product.id),
                //     icon: Icon(Icons.remove_circle),
                //   ),
                // );

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(
                          //       0.2,
                          //     ), // shadow color with opacity
                          //     spreadRadius: 2, // how wide the shadow spreads
                          //     blurRadius: 8, // softness of the shadow
                          //     offset: Offset(
                          //       2,
                          //       4,
                          //     ), // position of the shadow (x, y)
                          //   ),
                          // ],
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
                                icon: Icon(
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
                                icon: Icon(Icons.add_circle_outline, size: 20),
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
        padding: EdgeInsets.all(16),
        color: Colors.deepOrangeAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ₱${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            ElevatedButton(
              onPressed: cart.cartItems.isEmpty
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Checkout Successfull'),
                          content: Text('Thank you for your purchase!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                cart.clearCart();
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),

      // Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Text(
      //     'Total: ₱${cart.totalPrice.toStringAsFixed(2)}',
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      // ),
    );
  }
}
