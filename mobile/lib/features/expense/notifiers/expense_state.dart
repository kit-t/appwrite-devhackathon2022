import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_expenses_app/features/expense/models/expense.dart';
import 'package:the_expenses_app/features/auth/models/user.dart' as custom_user;
import 'package:the_expenses_app/utils/appwrite.dart';

class ExpenseState extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> setUser(custom_user.User? user) async {
    if (user != null) {
      await _getExpenses();
    } else {
      _expenses = [];
    }
    notifyListeners();
  }

  Future<void> _getExpenses() async {
    try {
      DocumentList result = await Appwrite.database.listDocuments(
        collectionId: Appwrite.expensesCollId,
        orderAttributes: ['date'],
        orderTypes: ['DESC'],
      );
      _expenses =
      List<Expense>.from(result.documents.map((e) => e.convertTo(Expense.fromJson)));
    } catch (e) {
      print(e);
    }
  }

  Future<Document?> createExpense(Expense expense) async {
    Document? result;
    try {
      result = await Appwrite.database.createDocument(
        collectionId: Appwrite.expensesCollId,
        documentId: 'unique()',
        data: expense.toJson(),
        read: ["user:${expense.userId}"],
        write: ["user:${expense.userId}"],
      );
      // _expenses.add(result.convertTo(Expense.fromJson));
      await _getExpenses();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return result;
  }
}