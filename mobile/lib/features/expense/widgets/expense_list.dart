import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses_app/features/expense/models/expense.dart';
import 'package:the_expenses_app/features/expense/notifiers/expense_state.dart';
import 'package:the_expenses_app/features/expense/widgets/expense_list_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Expense> expenses = Provider.of<ExpenseState>(context).expenses;
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return ExpenseListItem(expense: expenses[index]);
      },
    );
  }
}
