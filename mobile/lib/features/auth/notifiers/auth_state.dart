import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:the_expenses_app/constants/appwrite.dart';
import 'package:the_expenses_app/features/auth/models/user.dart';

class AuthState extends ChangeNotifier {
  Client client = Client();
  late Account account;
  late Storage storage;
  bool _isLoggedIn = false;
  User? _user;
  String? _error;
  Locale? locale;

  bool get isLoggedIn => _isLoggedIn;

  User? get user => _user;

  String? get error => _error;

  AuthState() {
    client
        .setEndpoint(AppwriteConstants.endpoint)
        .setProject(AppwriteConstants.projectId);
    account = Account(client);
    storage = Storage(client);
    locale = Locale(client);
    _checkIsLoggedIn();
  }

  _checkIsLoggedIn() async {
    try {
      _user = await _getAccount();
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      // print(e.message);
    }
  }

  Future<User?> _getAccount() async {
    try {
      Response<dynamic> res = (await account.get()) as Response;
      // if (res.statusCode == 200) {
      return User.fromJson(res.data);
      // } else {
      // return null;
      // }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createAccount(String name, String email, String password) async {
    try {
      var result = await account.create(
        userId: 'unique()',
        name: name,
        email: email,
        password: password,
      );
      print(result);
      // if (result.statusCode == 200) {
      _isLoggedIn = true;
      _user = await _getAccount();
      notifyListeners();
      // }
    } catch (e) {
      print(e); // print(e.message);
    }
    return _isLoggedIn;
  }

  logout() async {
    try {
      Response res = await account.deleteSession(sessionId: 'current');
      // print(res.statusCode);
      _isLoggedIn = false;
      _user = null;
      notifyListeners();
    } catch (e) {
      // _error = e.message;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      var result =
          await account.createSession(email: email, password: password);
      // if (result.statusCode == 201) {
      _isLoggedIn = true;
      _user = await _getAccount();
      notifyListeners();
      // }
    } catch (e) {
      // print(e.message);
    }
    return _isLoggedIn;
  }
}
