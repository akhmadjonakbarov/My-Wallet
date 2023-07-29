part of 'budget_cubit.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetWelcome extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final List<BudgetModel> budgets;
  const BudgetLoaded({required this.budgets});
}

class BudgetError extends BudgetState {
  final String errorMsg;
  const BudgetError({required this.errorMsg});
}
