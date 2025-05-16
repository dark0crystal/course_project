import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/models/userModal.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _usersCollection = 'users';

  // Create a new user
  Future<User?> createUser(User user) async {
    try {
      // Check if email already exists
      final emailQuery = await _firestore
          .collection(_usersCollection)
          .where('email', isEqualTo: user.email)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        throw Exception('Email already exists');
      }

      // Check if username already exists
      final usernameQuery = await _firestore
          .collection(_usersCollection)
          .where('userName', isEqualTo: user.userName)
          .get();

      if (usernameQuery.docs.isNotEmpty) {
        throw Exception('Username already exists');
      }

      // Create new user document
      final docRef = await _firestore.collection(_usersCollection).add({
        'userName': user.userName,
        'email': user.email,
        'password': user.password, // Note: In a real app, this should be hashed
      });

      return User(
        id: docRef.id,
        userName: user.userName,
        email: user.email,
        password: user.password,
      );
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Login user
  Future<User?> loginUser(String email, String password) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Invalid email or password');
      }

      final userData = querySnapshot.docs.first.data();
      return User(
        id: querySnapshot.docs.first.id,
        userName: userData['userName'],
        email: userData['email'],
        password: userData['password'],
      );
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
} 