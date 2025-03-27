import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  // instance of the Firebase 
  final FirebaseAuth _auth=FirebaseAuth.instance;  
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //get the CurrentUset
  User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  //sign in 
  Future<UserCredential> signInWithEmailAndPassword(String email,String password)async{
      try{
        UserCredential userCredential=await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
          );
          //save the User's info ,why are we saving the User's info ?
          _firestore.collection('users').doc(userCredential.user!.uid).set({
            'uid' :userCredential.user!.uid,
            'email' : email
          }); // Why we felt the Need of Storing this data sepaprate 
          return userCredential;
      }on FirebaseAuthException catch(e){
          throw Exception(e.code);
      }      
  }
  //sign Out method 
  Future<void> signOut()async{
    await _auth.signOut();
  }

  // Sign Up the User 
  Future<UserCredential> createUserWithEmailAndPassword(String email,String password)async{
      try{
        UserCredential userCredential=await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
          );

          //When you create a user , let's save this user info into a separate doc 
          _firestore.collection('users').doc(userCredential.user!.uid).set({
            'uid' :userCredential.user!.uid,
            'email' : email
          });
          return userCredential;
      }
      on FirebaseAuthException catch(e){
        print(e.code);
        throw Exception(e.code);
      }
  }

}