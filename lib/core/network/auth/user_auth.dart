import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a new user with email and password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =   await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Successful registration");
      return userCredential.user; // Successful registration
    } on FirebaseAuthException catch (e) {
      print(" registration error");
      return null;
      // return e.message; // Handle registration error
    }

  }

  // Sign in with email and password
  Future<bool?> signInWithEmailAndPassword(
      {required String email, required String password,required BuildContext context}) async {
    try {
      UserCredential userCredential =   await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        // User is signed in, you can perform actions for authenticated users here.
        print(" Successful login");
        print('User is signed in: ${user.email}');
        return true;
      } else {
        // User is not signed in.
        print('User is not signed in.');
        return false;
      }

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-In Error: ${e.code}}'),
          backgroundColor: Colors.red,
        ),
      );
      return false; // Handle login error
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check if a user is currently signed in
  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  // Get the current user's UID
  String? getCurrentUserUID() {
    return _auth.currentUser?.uid;
  }

  // Get the current user's email
  String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }

  // Send a password reset email
  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Successful request");
      return null; // Successful request
    } on FirebaseAuthException catch (e) {
      print("error request");
      return e.message; // Handle error
    }
  }

  Future<UserCredential?> signInAnonymously() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();

      return userCredential;
    } catch (e) {

      return null;
    }
  }
// Function to check if user is signed in anonymously
  bool isSignedInAnonymously() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null && user.isAnonymous;
  }
}
