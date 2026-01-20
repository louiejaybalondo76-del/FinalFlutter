import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screen/cart_screen.dart';
import 'package:e_commerce/screen/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  final List<Product> products = [
    Product(id: '1', name: 'Bag', price: 500, image: 'assets/bag.jpg'),
    Product(id: '2', name: 'Shoes', price: 1000, image: 'assets/shoes.jpg'),
    Product(id: '3', name: 'Watch', price: 5000, image: 'assets/watch.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
                icon: Icon(Icons.shopping_cart_outlined),
              ),

              if (cart.itemCount > 0)
                Positioned(
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text(
                      '${cart.itemCount}',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),

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
      ),

      // body: ListView.builder(
      //   padding: EdgeInsets.all(10),
      //   itemCount: products.length,
      //   itemBuilder: (context, index) {
      //     final product = products[index];
      //     return Card(
      //       child: ListTile(
      //         leading: Image.asset(product.image, width: 100),
      //         title: Text(product.name),
      //         subtitle: Text('₱${product.price.toStringAsFixed(2)}'),
      //         trailing: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             //side: BorderSide(color: Colors.deepPurpleAccent),
      //             backgroundColor: Colors.deepPurpleAccent,
      //             foregroundColor: Colors.white,
      //           ),
      //           onPressed: () {
      //             cart.addToCart(product);
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(content: Text('${product.name} added to cart')),
      //             );
      //           },

      //           child: Text('Add'),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .9,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            //surfaceTintColor: Colors.black45,
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(product.image, fit: BoxFit.contain),
                ),
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('₱${product.price.toStringAsFixed(2)}'),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      cart.addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.blueGrey,
                          content: Text('${product.name} added to cart'),
                          duration: Duration(milliseconds: 700),
                        ),
                      );
                    },
                    child: Text('Add to Cart'),
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
