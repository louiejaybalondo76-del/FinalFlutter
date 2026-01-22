import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screen/auth/login_screen.dart';
import 'package:e_commerce/screen/cart_screen.dart';
import 'package:e_commerce/screen/message_screen.dart';
import 'package:e_commerce/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _displayName = "ADIDAS USER";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayName = prefs.getString('saved_username') ?? "ADIDAS USER";
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'PROFILE',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            icon: const Icon(Icons.settings_outlined),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text('${cart.itemCount}', 
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('User.png'), 
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              _displayName.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: 1),
            ),
            const Text("user.example@email.com", style: TextStyle(color: Colors.grey, fontSize: 13)),

            const SizedBox(height: 30),

            // Dashboard Section (image_7f0592.png)
            _buildDashboardCard(
              title: "My Purchases",
              items: [
                _buildActionItem(Icons.account_balance_wallet_outlined, "To Pay"),
                _buildActionItem(Icons.inventory_2_outlined, "To Ship"),
                _buildActionItem(Icons.local_shipping_outlined, "To Receive", badge: "1"),
                _buildActionItem(Icons.star_outline, "To Rate"),
              ],
            ),

            const SizedBox(height: 15),

            _buildDashboardCard(
              title: "My Wallet",
              items: [
                _buildActionItem(Icons.account_balance_outlined, "AdidasPay", sub: "₱500.00"),
                _buildActionItem(Icons.confirmation_num_outlined, "Vouchers"),
                _buildActionItem(Icons.card_giftcard_outlined, "Points"),
              ],
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({required String title, required List<Widget> items}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Row(
                children: [
                  Text("View All", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
                ],
              ),
            ],
          ),
          const Divider(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, {String? badge, String? sub}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, size: 26, color: Colors.black87),
            if (badge != null)
              Positioned(
                right: -4,
                top: -4,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.red,
                  child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 9)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11)),
        if (sub != null)
          Padding(
            // FIXED PADDING SYNTAX HERE (image_7efdf8.png)
            padding: const EdgeInsets.only(top: 2), 
            child: Text(sub, style: const TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}