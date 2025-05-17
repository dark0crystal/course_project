import 'package:flutter/foundation.dart';
import 'package:course_project/models/userModal.dart';
import 'package:course_project/services/firestore_service.dart';

class AuthState extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _firestoreService.loginUser(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup(String userName, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _firestoreService.createUser(
        User(
          id: '',
          userName: userName,
          email: email,
          password: password,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
