import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hello! How can we help you today?",
      "isMe": false,
      "time": "9:00 AM"
    },
  ];

  String _getCurrentTime() {
    final now = DateTime.now();
    final String hour = now.hour > 12 ? (now.hour - 12).toString() : now.hour.toString();
    final String minute = now.minute.toString().padLeft(2, '0');
    final String ampm = now.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $ampm";
  }

  String _getAutoResponse(String userText) {
    String input = userText.toLowerCase();
    if (input.contains("available") || input.contains("stock")) {
      return "Checking our inventory... Most of our Shoes is in stock! Which size do you need?";
    } else if (input.contains("price") || input.contains("magkano")) {
      return "All prices are indicated on the product page. Do you have a specific item in mind?";
    } else if (input.contains("order") || input.contains("status")) {
      return "You can track your order in the Notifications tab! Impossible is nothing.";
    } else {
      return "Thanks for reaching out! A specialist will be with you shortly to assist with your Order.";
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    String userText = _messageController.text;

    setState(() {
      _messages.add({
        "text": userText,
        "isMe": true,
        "time": _getCurrentTime(),
      });
    });

    _messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add({
            "text": _getAutoResponse(userText),
            "isMe": false,
            "time": _getCurrentTime(),
          });
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'CUSTOMER SUPPORT',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildChatBubble(
                  message: msg['text'],
                  isMe: msg['isMe'],
                  time: msg['time'],
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble({required String message, required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isMe ? Colors.black : Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(isMe ? 15 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 15),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}