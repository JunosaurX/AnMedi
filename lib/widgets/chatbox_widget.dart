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
  late Animation<Color?> _glowAnimation;
  late Animation<double> _fadeScaleAnimation;
  final TextEditingController _chatController = TextEditingController();
  String _chatbotResponse = '';

  @override
  void initState() {
    super.initState();

    // Glow Animation for Border
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnimation = _controller.drive(
      TweenSequence<Color?>([
        TweenSequenceItem(
            tween: ColorTween(begin: Colors.blue, end: Colors.purple),
            weight: 1),
        TweenSequenceItem(
            tween: ColorTween(begin: Colors.purple, end: Colors.red),
            weight: 1),
        TweenSequenceItem(
            tween: ColorTween(begin: Colors.red, end: Colors.yellow),
            weight: 1),
        TweenSequenceItem(
            tween: ColorTween(begin: Colors.yellow, end: Colors.blue),
            weight: 1),
      ]),
    );

    // Fade & Scale Transition Animation
    _fadeScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
    return Positioned(
      bottom: 80,
      right: 16,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: widget.isVisible
            ? AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _fadeScaleAnimation.value,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _glowAnimation.value ?? Colors.blueAccent,
                          width: 3, // Glowing Border
                        ),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      _chatbotResponse,
                                      style:
                                          const TextStyle(color: Colors.white),
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
                                      icon: const Icon(Icons.send,
                                          color: Colors.white),
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
                    ),
                  );
                },
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
