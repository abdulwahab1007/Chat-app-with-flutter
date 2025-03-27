import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget{
    const ChatPage({
    super.key,
    required this.recieversEmail,
    required this.recieverId
    });
  //Just to know who we are chatting tooo , get the Reciever's email 
  final String recieversEmail;
  final String recieverId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text Controller 
  final TextEditingController _messageController=TextEditingController(); 

  //auth & chat Services
  final ChatService _chatService=ChatService();

  final AuthService _authService=AuthService();

  //send message 
  void sendMessage()async{
    //send message only if there is something inside the text Controller 
    if(_messageController.text.isNotEmpty){
      //send message then 
      await _chatService.sendMessage(widget.recieverId, _messageController.text);
      _messageController.clear();
    }
    scrollDown();
  }

  //Focus Node (WE Use focus Node to shift the Focus from one thing to another programtically , for example shifting the focus from one textfireld to another by using the listener )
  FocusNode myFocusNode=FocusNode();
  // Now we are going to work with this in the init State 
  // you would be needing to study this 
  @override
  void initState() {
    super.initState();
    //add the listener 
    myFocusNode.addListener((){
      if(myFocusNode.hasFocus){
        Future.delayed(
          const Duration(milliseconds: 500),
          ()=>scrollDown()
          );
      }
    });
    // So in the Initial State , We are going to scroll our chat upp tooo ! 
    // First fo all we are gonna wait for the list to build then we will call the Scrolldown function 
    Future.delayed(
      const Duration(milliseconds: 500),
      ()=>scrollDown()
      );
  }
    final ScrollController _scrollController=ScrollController();
  //scrollDown () mehtod 
  void scrollDown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // in  the offset we are telling ' how far to scroll'. 
      duration: const Duration(seconds: 1), 
      curve: Curves.fastOutSlowIn
      );
  }
 
  //dispose the focus node and controllers when we are not using it 
  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    _messageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Colors.grey,
        title:  Text(widget.recieversEmail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        
        ),
      // 
      body:  Column(
        children: [
          Expanded(
            child: _buildMessageList(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,),
              child: _buildMessageInput(),
            )

        ],
      ),
      // Here we are going to build our Ui for tht Chat page 
    );
  }

  //buildMessageList
  Widget _buildMessageList(){
    //get the currentUserID 
    String senderId=_authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, widget.recieverId),// it will wait for the messages   
      builder: (context,snapshot){
          //check if there are any errors 
          if(snapshot.hasError){
            return const Text('ERROR..');
          }        
          //check if the connection is okay 
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text('loading..');
          }
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
          );
      }
      );
  }

  //buildMessageItem 
  Widget _buildMessageItem(QueryDocumentSnapshot doc){
    Map<String,dynamic> data=doc.data() as Map<String,dynamic>;

    // Align all of them on the Right side if it is the current User 
    bool isCurrentUser=data['senderId']==_authService.getCurrentUser()!.uid;
    // Align messages to the Right if it is the Current User , otherwise on the left
    var alignment=isCurrentUser? Alignment.centerRight :Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(
        isCurrentUser: isCurrentUser, 
        message: data['message']
        )
      );
      
  }

  //Biuld Message Input 
  Widget _buildMessageInput(){
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: _messageController, 
            hintText: 'Type a Message ', 
            obscureText: false,
            focusNode: myFocusNode,
            ),
        ),
        
        Container(
          margin: const EdgeInsets.only(right: 5),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle
          ),
          child: IconButton(
            onPressed: sendMessage, 
            icon: const Icon(Icons.arrow_upward)
            ),
        )
      ],
    );
  }
}