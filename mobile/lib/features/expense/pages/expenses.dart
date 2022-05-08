import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses_app/features/auth/notifiers/auth_state.dart';
import 'package:the_expenses_app/features/expense/widgets/add_expense.dart';
import 'package:the_expenses_app/features/expense/widgets/expense_list.dart';
import 'package:the_expenses_app/routes.dart';

import '../notifiers/expense_state.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  static final titles = ['Expenses', 'Add Expense'];
  final items = (BuildContext context) => [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: titles[0],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: titles[1],
        ),
      ];
  late PlatformTabController _tabController;
  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    _tabController = PlatformTabController(
      initialIndex: 0,
    );

    tabs = [
      ExpenseList(),
      AddExpense(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTabScaffold(
      tabController: _tabController,
      appBarBuilder: (_, index) => PlatformAppBar(
        title: PlatformText(titles[index]),
        trailingActions: [
          PlatformIconButton(
            materialIcon: const Icon(Icons.logout),
            cupertinoIcon: const Icon(Icons.logout),
            onPressed: () {
              AuthState state = Provider.of<AuthState>(context, listen: false);
              state.logout();
              Provider.of<ExpenseState>(context, listen: false).setUser(null);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          )
        ],
      ),
      bodyBuilder: (context, index) => IndexedStack(
        index: index,
        children: tabs,
      ),
      items: items(context),
    );
  }
}
