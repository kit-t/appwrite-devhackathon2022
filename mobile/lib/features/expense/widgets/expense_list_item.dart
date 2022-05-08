import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_expenses_app/features/expense/models/expense.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(CupertinoIcons.money_dollar_circle),
      title: Text(
        "${expense.name}",
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: Text(
        DateFormat.yMMMEd().format(expense.date),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Text(
        expense.totalAmt.toStringAsFixed(2),
      ),
    );
  }
}
