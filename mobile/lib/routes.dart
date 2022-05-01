import 'package:flutter/material.dart';
import 'package:the_expenses_app/features/auth/pages/login.dart';
import 'package:the_expenses_app/features/auth/pages/signup.dart';
import 'package:the_expenses_app/features/expense/pages/expenses.dart';

class AppRoutes {
  static const String login = "login";
  static const String signup = "signup";
  static const String home = "home";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case home:
          return const ExpensesPage();
        case signup:
          return const SignUpPage();
        case login:
        default:
          return const LoginPage();
      }
    });
  }
}
