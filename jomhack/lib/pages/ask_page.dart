import 'package:flutter/material.dart';

class AskPage extends StatefulWidget {
  const AskPage({Key? key}) : super(key: key);

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  // Add preset questions
  final List<String> _presetQuestions = [
    "What if I reduce my daily spending by RM10?",
    "How will investing RM500 monthly affect my retirement savings?",
    "Can I afford to buy a property in 5 years?",
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _controller.clear();
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
      // Simulate AI response
      _simulateResponse(text);
    });
    _scrollToBottom();
  }

  void _simulateResponse(String question) {
    Future.delayed(const Duration(seconds: 1), () {
      // For saving money scenarios
      if (question.toLowerCase().contains('save money')) {
        setState(() {
          _messages.add(ChatMessage(
            text: "It's time to give up Shopee",
            isUser: false,
          ));
          _messages.add(ChatMessage(
            text: "Potential savings\nmonthly: RM350\nyearly: RM2223",
            isUser: false,
            isHighlighted: true,
          ));
        });
      }
      // For investment scenarios
      else if (question.toLowerCase().contains('investing rm500') || 
               question.toLowerCase().contains('invest 500')) {
        setState(() {
          _messages.add(ChatMessage(
            text: "Based on your financial twin simulation:",
            isUser: false,
          ));
          _messages.add(ChatMessage(
            text: "If you invest RM500 monthly with an average return of 6% p.a.:\n\n" +
                 "In 10 years: RM78,227\n" +
                 "In 20 years: RM206,932\n" +
                 "In 30 years: RM474,349",
            isUser: false,
            isHighlighted: true,
          ));
        });
      }
      // For property purchase scenarios
      else if (question.toLowerCase().contains('property') || 
               question.toLowerCase().contains('house')) {
        setState(() {
          _messages.add(ChatMessage(
            text: "Based on your current financial health:",
            isUser: false,
          ));
          _messages.add(ChatMessage(
            text: "Property Purchase Feasibility in 5 years:\n\n" +
                 "✓ Down payment savings: RM48,000\n" +
                 "✓ Estimated loan eligibility: RM450,000\n" +
                 "✗ Debt Service Ratio: 75% (Should be below 70%)\n\n" +
                 "Recommendation: Reduce current debts by RM15,000 to improve eligibility",
            isUser: false,
            isHighlighted: true,
          ));
        });
      }
      // For daily spending reduction
      else if (question.toLowerCase().contains('reduce') && 
               question.toLowerCase().contains('daily')) {
        setState(() {
          _messages.add(ChatMessage(
            text: "Impact of reducing RM10 daily spending:",
            isUser: false,
          ));
          _messages.add(ChatMessage(
            text: "Monthly savings: RM300\n" +
                 "Yearly savings: RM3,650\n\n" +
                 "If invested at 6% p.a.:\n" +
                 "5-year growth: RM21,450\n" +
                 "10-year growth: RM49,890",
            isUser: false,
            isHighlighted: true,
          ));
        });
      }
      // Default response for other questions
      else {
        setState(() {
          _messages.add(ChatMessage(
            text: "I can help you with financial simulations like:\n\n" +
                 "• What if I reduce my daily spending by RM10?\n" +
                 "• How will investing RM500 monthly affect my retirement savings?\n" +
                 "• Can I afford to buy a property in 5 years?\n\n" +
                 "Just ask any of these questions!",
            isUser: false,
          ));
        });
      }
      _scrollToBottom();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Savy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            Text(
              'Ask me anything about finance',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Add preset questions section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _presetQuestions.map((question) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _messages.add(ChatMessage(
                            text: question,
                            isUser: true,
                          ));
                          _simulateResponse(question);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF2E3192),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                      child: Text(
                        question,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -4),
                  blurRadius: 12,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Ask me anything about your finances...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded),
                      color: Colors.white,
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _handleSubmitted(_controller.text);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isHighlighted;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUser,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) 
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.assistant,
                color: Colors.white,
                size: 18,
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? Colors.white
                    : isHighlighted
                        ? const Color(0xFF2E3192)
                        : const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser
                      ? const Color(0xFF1E1E1E)
                      : isHighlighted
                          ? Colors.white
                          : const Color(0xFF1E1E1E),
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (isUser)
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF2E3192),
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
} 