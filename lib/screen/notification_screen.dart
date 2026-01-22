import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screen/cart_screen.dart';
import 'package:e_commerce/screen/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  String _getButtonText(String title) {
    if (title.contains('GEAR')) return 'TRACK ORDER';
    if (title.contains('DROP')) return 'SHOP NOW';
    if (title.contains('MOVE')) return 'VIEW MAP';
    return 'VIEW DETAILS';
  }

  @override
  Widget build(BuildContext context) {
    // Kinukuha ang notifications mula sa Provider
    final cart = Provider.of<CartProvider>(context);
    final notifications = cart.notifications; // Eto na yung dynamic list

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          'NOTIFICATIONS',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
        actions: [
          // Shopping Bag Icon with Badge
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8, top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text('${cart.itemCount}', style: const TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MessageScreen())),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                final bool isUnread = item['unread'] == true;

                return Container(
                  decoration: BoxDecoration(
                    color: isUnread ? Colors.grey.shade100 : Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
                      left: BorderSide(color: isUnread ? Colors.black : Colors.transparent, width: 4),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        leading: Icon(item['icon'] as IconData, color: Colors.black, size: 28),
                        title: Text(item['title'].toString(), style: TextStyle(fontWeight: isUnread ? FontWeight.w900 : FontWeight.bold, fontSize: 14, letterSpacing: 1)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(item['message'].toString(), style: const TextStyle(color: Colors.black87, fontSize: 13)),
                        ),
                        trailing: Text(item['time'].toString(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 65, bottom: 15, right: 20),
                        child: Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black, width: 1.5),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                minimumSize: const Size(0, 32),
                              ),
                              child: Text(_getButtonText(item['title'].toString()), style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.notifications_none, size: 100, color: Colors.black),
          SizedBox(height: 20),
          Text('NO UPDATES YET', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2)),
          SizedBox(height: 10),
          Text('IMPOSSIBLE IS NOTHING', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}