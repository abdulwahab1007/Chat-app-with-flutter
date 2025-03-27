import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget{
    ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.message
    });
    // We need the message and the boolean value of (isCurrentUser)
  final bool isCurrentUser;
  final String message;
  
  
  @override
  Widget build(BuildContext context) {
    bool isDarkMode=Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 20.0),
      decoration: BoxDecoration(
        color: isCurrentUser ?
        (isDarkMode ? Colors.green.shade600 : Colors.grey.shade500):
        (isDarkMode ? Colors.grey.shade800 :Colors.grey.shade200),

        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Text(message,style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
    );
  }
}