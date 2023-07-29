part of 'expense_cubit.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState({this.expenses});
  final List<ExpenseModel>? expenses;

  @override
  List<Object> get props => [];
}

class ExpenseWelcome extends ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<ExpenseModel> expenses;
  const ExpenseLoaded({required this.expenses});
}

class ExpenseDelete extends ExpenseState {}

class ExpenseError extends ExpenseState {
  final String errorMsg;
  const ExpenseError({required this.errorMsg});
}
