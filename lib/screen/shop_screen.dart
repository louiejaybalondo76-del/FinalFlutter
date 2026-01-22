import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screen/cart_screen.dart';
import 'package:e_commerce/screen/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<Product> allProducts = [
    Product(id: '1', name: 'Red Shoes Adidas', price: 4999, image: 'assets/img1.png'),
    Product(id: '2', name: 'Black Shoes Adidas', price: 999, image: 'assets/img2.png'),
    Product(id: '3', name: 'White Shoes Adidas', price: 4999, image: 'assets/img3.png'),
    Product(id: '4', name: 'Purple Shoes Adidas', price: 4999, image: 'assets/img4.png'),
  ];

  List<Product> displayedProducts = [];

  @override
  void initState() {
    super.initState();
    displayedProducts = allProducts;
  }

  void _runSearch(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = allProducts;
    } else {
      results = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      displayedProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            height: 40,
            child: TextField(
              onChanged: (value) => _runSearch(value),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text('${cart.itemCount}', 
                      style: const TextStyle(color: Colors.red, fontSize: 12)),
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MessageScreen())),
            icon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
      body: displayedProducts.isEmpty
          ? const Center(child: Text('No products found.', style: TextStyle(fontSize: 18, color: Colors.grey)))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: displayedProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .85,
              ),
              itemBuilder: (context, index) {
                final product = displayedProducts[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.50),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(product.image, fit: BoxFit.contain),
                        ),
                      ),
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('₱${product.price.toStringAsFixed(2)}'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            cart.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color.fromARGB(239, 0, 170, 255),
                                content: Text('${product.name} added to cart'),
                                duration: const Duration(milliseconds: 700),
                              ),
                            );
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}