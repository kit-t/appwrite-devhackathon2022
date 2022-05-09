import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:the_expenses_app/features/auth/notifiers/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses_app/features/expense/notifiers/expense_state.dart';
import 'package:the_expenses_app/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Login'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 10.0),
            PlatformTextField(
              controller: _email,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10.0),
            PlatformTextField(
              controller: _password,
              obscureText: true,
              hintText: "Password",
            ),
            const SizedBox(height: 10.0),
            Center(
              child: PlatformElevatedButton(
                child: PlatformText("Login"),
                onPressed: () async {
                  AuthState state = Provider.of<AuthState>(context, listen: false);
                  if (await state.login(_email.text, _password.text)) {
                    Provider.of<ExpenseState>(context, listen: false).setUser(state.user);
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  }
                },
              ),
            ),
            const SizedBox(height: 10.0),
            PlatformTextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.signup),
              child: const Text("Create account"),
            ),
          ],
        ),
      ),
    );
  }
}
