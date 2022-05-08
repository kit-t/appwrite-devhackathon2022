import 'package:flutter/widgets.dart';
import 'package:the_expenses_app/features/auth/models/user.dart';
import 'package:the_expenses_app/utils/appwrite.dart';

class AuthState extends ChangeNotifier {
  User? _user;

  bool get isLoggedIn => _user != null;
  User? get user => _user;

  AuthState() {
    _checkIsLoggedIn();
  }

  _checkIsLoggedIn() async {
    try {
      _user = await _getAccount();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<User?> _getAccount() async {
    try {
      final result = await Appwrite.account.get();
      return User.fromJson(result.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createAccount(String name, String email, String password) async {
    try {
      await Appwrite.account.create(
        userId: 'unique()',
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
    return login(email, password);
  }

  logout() async {
    _user = null;
    notifyListeners();
    try {
      await Appwrite.account.deleteSession(sessionId: 'current');
    } catch (e) {
      print(e);
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await Appwrite.account.createSession(email: email, password: password);
      _user = await _getAccount();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return isLoggedIn;
  }
}
