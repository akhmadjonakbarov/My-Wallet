import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../models/expense_model.dart';
import '../../db/expense_operation.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseInitial()) {
    ExpenseOperation.getData().then((data) {
      if (data.isEmpty) {
        emit(ExpenseWelcome());
      } else {
        filterByMonth(
          dateTime: DateTime.now(),
        );
      }
    });
  }

  void add({
    required String title,
    required double price,
    required double amount,
    required IconData iconData,
    required String iconFont,
    required String iconPackage,
    required DateTime dateTime,
  }) async {
    List<ExpenseModel> expenses = await ExpenseOperation.getData();
    try {
      ExpenseModel expense = ExpenseModel(
        id: UniqueKey().toString(),
        title: title,
        amount: amount,
        price: price,
        iconData: iconData.codePoint,
        iconFont: iconFont,
        iconPackage: iconPackage,
        dateTime: dateTime,
      );
      expenses.insert(0, expense);
      emit(ExpenseLoaded(expenses: expenses));
      ExpenseOperation.insertData(data: expense.toMap());
    } catch (e) {
      emit(
        ExpenseError(errorMsg: e.toString()),
      );
    }
  }

  // void update({required Expense expense}) async {
  //   List<Expense> expenses = await ExpenseOperation.getData();
  //   try {
  //     expenses = expenses.map((e) {
  //       if (e.id == expense.id) {
  //         ExpenseOperation.updateData(expense: expense);
  //         return Expense(
  //           id: expense.id,
  //           title: expense.title,
  //           amount: expense.amount,
  //           price: expense.price,
  //           iconData: expense.iconData,
  //           iconFont: expense.iconFont,
  //           iconPackage: expense.iconPackage,
  //           dateTime: expense.dateTime,
  //         );
  //       }
  //       return e;
  //     }).toList();
  //     emit(ExpenseLoaded(expenses: expenses));
  //   } catch (e) {
  //     emit(
  //       ExpenseError(errorMsg: e.toString()),
  //     );
  //   }
  // }

  void delete({required ExpenseModel expense}) async {
    List<ExpenseModel> expenses = await ExpenseOperation.getData();
    try {
      emit(ExpenseLoading());
      expenses.removeWhere((element) => element.id == expense.id);
      if (expenses.isNotEmpty) {
        emit(
          ExpenseLoaded(
            expenses: expenses,
          ),
        );
      } else {
        emit(ExpenseWelcome());
      }
      ExpenseOperation.deleteData(expense: expense);
    } catch (e) {
      emit(
        ExpenseError(errorMsg: e.toString()),
      );
    }
  }

  Future<List<ExpenseModel>> searchExpense({String? title}) async {
    List<ExpenseModel> expenses = await ExpenseOperation.getData();
    return expenses
        .where(
          (element) => element.title.toLowerCase().contains(
                title!.toLowerCase(),
              ),
        )
        .toList();
  }

  Future<double> totalExpenseByMonth({required DateTime dateTime}) async {
    List<ExpenseModel> expenses = [];
    List<ExpenseModel> filteredExpenses = [];
    double totalSum = 0.0;
    expenses = await ExpenseOperation.getData();
    filteredExpenses = expenses.isNotEmpty
        ? expenses
            .where(
              (element) => element.dateTime.month == dateTime.month && element.dateTime.year == dateTime.year,
            )
            .toList()
        : [];
    for (var element in filteredExpenses) {
      totalSum = totalSum + element.price;
    }
    return totalSum;
  }

  Future<void> filterByMonth({required DateTime dateTime}) async {
    List<ExpenseModel> expenses = [];
    List<ExpenseModel> filteredExpenses = [];
    emit(ExpenseInitial());
    try {
      expenses = await ExpenseOperation.getData();

      filteredExpenses = expenses.isNotEmpty
          ? expenses
              .where(
                (element) => element.dateTime.month == dateTime.month && element.dateTime.year == dateTime.year,
              )
              .toList()
          : [];
      filteredExpenses.isNotEmpty ? emit(ExpenseLoaded(expenses: filteredExpenses)) : emit(ExpenseWelcome());
    } catch (e) {
      emit(
        ExpenseError(errorMsg: e.toString()),
      );
    }
  }
}
