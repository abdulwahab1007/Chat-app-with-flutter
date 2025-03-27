import 'package:chat_app/components/user_item.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
   const HomePage({super.key});
   

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user=FirebaseAuth.instance.currentUser;

  // create a method again , it 's a long way to go , ahhh 
  final ChatService _chatService=ChatService();

  final AuthService _authService=AuthService();

  void logout(){
    //instance
    AuthService authService=AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Colors.grey,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('HOME')
      ),
      drawer:  MyDrawer(
        onTap: logout,
        ),
        body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
      return StreamBuilder(
        stream: _chatService.getUserStream(), 
        builder: (context,snapshot){
          //let's check First of all that if the Snapshot has any errors 
          if(snapshot.hasError){
            return const Text('Error...');
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text('loading..');
          }
          return ListView(children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData,context)).toList());
        }
        );
  }

  Widget _buildUserListItem(Map<String,dynamic> userData,BuildContext context){
    if(userData['email'] !=_authService.getCurrentUser()!.email){
      //comparing the emails 
      return UserItem(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(
          recieversEmail: userData['email'], 
          recieverId: userData['uid'],
        )));
      }, 
      title: userData['email']
      );
    }
    else{
      return Container();
    }
  }
}