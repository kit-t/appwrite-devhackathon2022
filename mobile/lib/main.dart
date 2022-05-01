import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses_app/features/auth/notifiers/auth_state.dart';
import 'package:the_expenses_app/features/auth/pages/login.dart';
import 'package:the_expenses_app/features/expense/pages/expenses.dart';
import 'package:the_expenses_app/routes.dart';

void main() {
  runApp(const TheExpensesApp());
}

class TheExpensesApp extends StatelessWidget {
  const TheExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthState(),
          lazy: false,
        ),
      ],
      child: PlatformApp(
        title: 'The Expenses App',
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: Consumer<AuthState>(
          builder: (context, state, child) {
            return state.isLoggedIn
                ? const ExpensesPage()
                : const LoginPage();
          },
        ),
      ),
    );
  }
}

