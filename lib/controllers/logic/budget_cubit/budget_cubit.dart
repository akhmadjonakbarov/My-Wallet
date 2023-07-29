import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/models/budget_model.dart';

import '../../db/budget_operation.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetInitial()) {
    BudgetOperation.getData().then((value) {
      if (value.isEmpty) {
        emit(BudgetWelcome());
      } else {
        filterByMonth(
          dateTime: DateTime.now(),
        );
      }
    });
  }

  void add({required double value, required DateTime dateTime}) async {
    List<BudgetModel> budgets = await BudgetOperation.getData();
    try {
      BudgetModel budget = BudgetModel(
        id: UniqueKey().toString(),
        amount: value,
        dateTime: dateTime,
      );
      budgets.add(budget);
      emit(BudgetLoaded(budgets: budgets));
      BudgetOperation.insertData(
        data: budget.toMap(),
      );
    } catch (e) {
      emit(
        BudgetError(
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void update({required BudgetModel budget}) async {
    List<BudgetModel> budgets = await BudgetOperation.getData();
    try {
      budgets = budgets.map((e) {
        if (e.id == budget.id) {
          BudgetOperation.updateData(budget: budget);
          return BudgetModel(id: budget.id, amount: budget.amount, dateTime: budget.dateTime);
        }
        return e;
      }).toList();
    } catch (e) {
      emit(
        BudgetError(errorMsg: e.toString()),
      );
    }
  }

  Future getLastBudget({required DateTime dateTime}) async {
    List<dynamic> budgets = await BudgetOperation.getData();

    List<dynamic> filteredBudgets = [];

    filteredBudgets = budgets.isNotEmpty
        ? budgets
            .where(
              (budget) => budget.dateTime.month == dateTime.month && budget.dateTime.year == dateTime.year,
            )
            .toList()
        : [];

    return filteredBudgets.isNotEmpty ? filteredBudgets.last : null;
  }

  Future<void> filterByMonth({required DateTime dateTime}) async {
    List<BudgetModel> budgets = [];
    List<BudgetModel> filteredBudgets = [];
    emit(BudgetInitial());
    try {
      budgets = await BudgetOperation.getData();

      filteredBudgets = budgets.isNotEmpty
          ? budgets
              .where(
                (element) => element.dateTime.month == dateTime.month && element.dateTime.year == dateTime.year,
              )
              .toList()
          : [];
      filteredBudgets.isNotEmpty ? emit(BudgetLoaded(budgets: filteredBudgets)) : emit(BudgetWelcome());
    } catch (e) {
      emit(
        BudgetError(
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
