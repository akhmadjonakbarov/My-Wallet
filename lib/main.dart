import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/logic/budget_cubit/budget_cubit.dart';
import 'controllers/logic/expense_cubit/expense_cubit.dart';
import 'views/screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ExpenseCubit(),
        ),
        BlocProvider.value(
          value: BudgetCubit(),
        )
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
