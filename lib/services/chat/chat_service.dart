import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatService {

  //get the instance of the Firestore 
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  //getUserStream() method to get all the users 
  

  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection('users').snapshots().map((snapshot){
      // Now We are going to convert this QuerySnapshot object into a Map<String,dynamic>
      return snapshot.docs.map((doc){
        final user=doc.data();
        return user;
      }).toList();
    });
  }

  //send  messages
  Future<void> sendMessage(String recieverId,String message)async{
    //First of all get the User's info 
    String currentUserId=_auth.currentUser!.uid;
    String currentUserEmail=_auth.currentUser!.email!;
    Timestamp timestamp=Timestamp.now();
    //create a model of the message , make a function to convert it into a map , to store the data into the database
    //now Create a new Message 
    Message newMessage=Message(
      senderId: currentUserId, 
      senderEmail: currentUserEmail, 
      recieverId: recieverId, 
      message: message, 
      timestamp: timestamp
      );
      //Create a Chatroom Id  for the two Users , and Store all these messages in the databse ,First of all we need to join both users id's to get the Uniquiness
      List<String> ids=[currentUserId,recieverId];
      ids.sort(); //this ensures that the ChatRoom Id is the same for both of the Users
      String chatRoomId=ids.join('_');

      // Add new Messages to the Database 
      await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());  
      // It is requiring the casting to work 
  } 

  // get  Messages 

  Stream<QuerySnapshot> getMessages(String userid,String otherUserId){
    // It is quiet similar to the send messages thing 
    List<String> ids=[userid,otherUserId];
    ids.sort(); // you need to sort them out for the uniqueness and for the both users to have same Chat Room Id
    String chatRoomId=ids.join('_');  //generated a ChatRoom Id 
    //now get the messages from database 
    return _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').
    orderBy('timestamp',descending: false).snapshots();
    
  }
}
