import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses_app/features/expense/models/expense.dart';
import 'package:the_expenses_app/features/expense/notifiers/expense_state.dart';
import 'package:the_expenses_app/features/expense/widgets/fullscreen_image.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: expense.attachmentId != null
          ? FutureBuilder(
              future: Provider.of<ExpenseState>(context, listen: false)
                  .getAttachmentPreview(expense.attachmentId!),
              builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                return snapshot.hasData && snapshot.data != null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return FullscreenImage(
                              child: Image.memory(snapshot.data!),
                              tag: expense.attachmentId!,
                            );
                          }));
                        },
                        child: Hero(
                          tag: expense.attachmentId!,
                          child: Image.memory(snapshot.data!),
                        ))
                    : const CircularProgressIndicator();
              })
          : const Icon(
              CupertinoIcons.money_dollar_circle,
              size: 36.0,
            ),
      title: Text(
        expense.name,
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
