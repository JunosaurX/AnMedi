import 'dart:ui';
import 'package:flutter/material.dart';

class ChatboxWidget extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onClose;

  const ChatboxWidget({
    Key? key,
    required this.isVisible,
    required this.onClose,
  }) : super(key: key);

  @override
  _ChatboxWidgetState createState() => _ChatboxWidgetState();
}

class _ChatboxWidgetState extends State<ChatboxWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  final TextEditingController _chatController = TextEditingController();
  String _chatbotResponse = '';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _chatController.dispose();
    super.dispose();
  }

  void _sendMessageToChatbot() {
    final message = _chatController.text.trim();
    if (message.isEmpty) return;

    setState(() => _chatbotResponse = '...loading response');

    // Simulate response (Replace with actual API call)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _chatbotResponse = 'Response to "$message"');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return SizedBox.shrink();

    return Positioned(
      bottom: 80,
      right: 16,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(_glowAnimation.value),
                      blurRadius: 20 + (_glowAnimation.value * 10),
                      spreadRadius: 3 + (_glowAnimation.value * 2),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              _chatbotResponse,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _chatController,
                          decoration: InputDecoration(
                            hintText: 'Ask me anything...',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send, color: Colors.white),
                              onPressed: _sendMessageToChatbot,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: widget.onClose,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
