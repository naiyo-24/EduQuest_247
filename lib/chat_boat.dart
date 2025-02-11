import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';


class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'message': _controller.text});
      _messages.add({'role': 'bot', 'message': getResponse(_controller.text)});
      _controller.clear();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String getResponse(String question) {
    if (question.toLowerCase().contains('courses') &&
        question.toLowerCase().contains('ai')) {
      return 'For a career in AI, you should consider courses like Machine Learning, Deep Learning, and Data Science.';
    } else if (question.toLowerCase().contains('internships') &&
        question.toLowerCase().contains('marketing')) {
      return 'Some of the best internships in marketing can be found at companies like Google, HubSpot, and Salesforce.';
    } else {
      return 'I am sorry, I do not have an answer to that question. Please try asking something else.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Career Assistant',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['role'] == 'user';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper6(
                        type: isUser
                            ? BubbleType.sendBubble
                            : BubbleType.receiverBubble,
                      ),
                      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: isUser ? 0 : 50,
                        left: isUser ? 50 : 0,
                      ),
                      backGroundColor:
                          isUser ? Theme.of(context).primaryColor : Colors.white,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          message['message']!,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded),
                      color: Colors.black,
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
