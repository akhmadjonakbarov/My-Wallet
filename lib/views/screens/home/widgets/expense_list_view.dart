import 'package:flutter/material.dart';

import '../../../../controllers/logic/expense_cubit/expense_cubit.dart';
import '../../../../models/expense_model.dart';
import './widgets.dart';

class ExpenseListView extends StatelessWidget {
  List<ExpenseModel> expenses;
  ExpenseListView({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        ExpenseModel expense = expenses[index];
        return ExpenseTile(expense: expense);
      },
    );
  }
}
