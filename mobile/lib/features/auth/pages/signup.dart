import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses_app/features/auth/notifiers/auth_state.dart';
import 'package:the_expenses_app/features/expense/notifiers/expense_state.dart';
import 'package:the_expenses_app/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Sign Up'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            PlatformTextField(
              controller: _name,
              hintText: 'Name',
            ),
            const SizedBox(height: 10.0),
            PlatformTextField(
              controller: _email,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10.0),
            PlatformTextField(
              controller: _password,
              obscureText: true,
              hintText: 'Password',
            ),
            const SizedBox(height: 10.0),
            Center(
              child: PlatformElevatedButton(
                child: PlatformText('Sign Up'),
                onPressed: () async {
                  AuthState state =
                      Provider.of<AuthState>(context, listen: false);
                  if (await state.createAccount(
                      _name.text, _email.text, _password.text)) {
                    Provider.of<ExpenseState>(context, listen: false).setUser(state.user);
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  }
                },
              ),
            ),
            const SizedBox(height: 10.0),
            PlatformTextButton(
              child: const Text('Already have an account? Login'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.login),
            )
          ],
        ),
      ),
    );
  }
}
