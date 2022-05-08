import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses_app/features/auth/notifiers/auth_state.dart';
import 'package:the_expenses_app/features/expense/models/expense.dart';
import 'package:the_expenses_app/features/expense/notifiers/expense_state.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _totalAmt = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String? _attachment;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 10.0),
        PlatformTextField(
          controller: _name,
          hintText: "Expense Name",
        ),
        const SizedBox(height: 10.0),
        PlatformTextField(
          controller: _totalAmt,
          hintText: 'Total',
          keyboardType: TextInputType.number,
          // TODO: validate using validators
        ),
        const SizedBox(height: 10.0),
        PlatformTextField(
          controller: _date,
          hintText: 'Date',
          onTap: () {
            _selectDate(context);
          },
          readOnly: true,
        ),
        const SizedBox(height: 10.0),
        PlatformElevatedButton(
          child: const Text('Attachment'),
          onPressed: () async {
            XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
            setState(() {
              _attachment = image?.path;
            });
          },
        ),
        Center(
          child: Text(_attachment?.split('/').last ?? ""),
        ),
        const SizedBox(height: 10.0),
        PlatformElevatedButton(
          child: const Text('Save'),
          onPressed: () async {
            String? userId =
                Provider.of<AuthState>(context, listen: false).user?.id;
            try {
              Expense expense = Expense(
                name: _name.text,
                totalAmt: double.parse(_totalAmt.text),
                date: DateTime.parse(_date.text),
                userId: userId,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              ExpenseState expenseState =
                  Provider.of<ExpenseState>(context, listen: false);
              if (await expenseState.createExpense(expense, attachmentPath: _attachment) != null) {
                _name.clear();
                _totalAmt.clear();
                _date.clear();
                setState(() {
                  _attachment = null;
                });
              }
            } catch (e) {
              print(e);
            }
          },
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? _selectedDate = await showPlatformDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 10000)),
      lastDate: DateTime.now(),
    );
    if (_selectedDate != null) {
      _date.text = DateFormat("yyyy-MM-dd").format(_selectedDate);
    }
  }
}
