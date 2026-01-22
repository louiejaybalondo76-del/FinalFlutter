import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screen/cart_screen.dart';
import 'package:e_commerce/screen/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void _updateSearch(String query) {
    setState(() {
      displayedProducts = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
              onChanged: _updateSearch,
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text(
                      '${cart.itemCount}',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MessageScreen()));
            },
            icon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const Text(
              'Welcome to Adidas Shoes Shop',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your ultimate shopping experience',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 50),
            
            displayedProducts.isEmpty
                ? const Center(child: Text("No products found."))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.50),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(product.image, fit: BoxFit.fill),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}