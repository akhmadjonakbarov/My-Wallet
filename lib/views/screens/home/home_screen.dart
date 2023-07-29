import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../controllers/logic/budget_cubit/budget_cubit.dart';
import '../../../controllers/logic/expense_cubit/expense_cubit.dart';
import '../../../models/budget_model.dart';
import './widgets/widgets.dart';
import './widgets/budget/edit_budget_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size size;
  DateTime _selectedDate = DateTime.now();
  double totalSum = 0.0;
  double totalSumPercentage = 0.0;
  BudgetModel? budget;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;

    super.didChangeDependencies();
  }

  void showCalendar() {
    showMonthPicker(
      context: context,
      firstDate: DateTime(2020),
      initialDate: DateTime.now(),
      lastDate: null,
    ).then((selectedDate) {
      setState(() {
        _selectedDate = selectedDate!;
      });
    });
  }

  void previousMonth() {
    if (_selectedDate.year == 2020 && _selectedDate.month == 1) {
      return;
    }
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month - 1,
        _selectedDate.day,
      );
    });
    BlocProvider.of<ExpenseCubit>(context).filterByMonth(
      dateTime: _selectedDate,
    );
    BlocProvider.of<BudgetCubit>(context).filterByMonth(
      dateTime: _selectedDate,
    );
  }

  void nextMonth() {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + 1,
        _selectedDate.day,
      );
    });
    BlocProvider.of<ExpenseCubit>(context).filterByMonth(
      dateTime: _selectedDate,
    );
    BlocProvider.of<BudgetCubit>(context).filterByMonth(
      dateTime: _selectedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BudgetCubit>(context).getLastBudget(dateTime: _selectedDate).then((value) {
      print("VALL $value");
      if (value != null) {
        print("SUCCESS");
        setState(() {
          budget = value;
        });
        BlocProvider.of<ExpenseCubit>(context).totalExpenseByMonth(dateTime: _selectedDate).then((value) {
          setState(() {
            totalSum = value;
            double x = budget!.amount != 0.0 ? budget!.amount : budget!.amount;
            totalSumPercentage = totalSum * 100 / x;
            totalSumPercentage = totalSumPercentage > 100 ? 100 : totalSumPercentage;
          });
        });
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Wallet'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
            ),
            ListTile(
              onTap: () {},
              title: const Text("Budget"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Header(
              totalSum: totalSum,
              showCalendar: showCalendar,
              previousMonth: previousMonth,
              nextMonth: nextMonth,
              selectedDate: _selectedDate,
              size: size,
            ),
            Container(
              decoration: const BoxDecoration(),
              height: size.height * 0.68,
              child: LayoutBuilder(
                builder: (p0, p1) {
                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 4,
                        ),
                        width: double.infinity,
                        height: p1.maxHeight,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 227, 227, 240),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Oylik budjet:"),
                                    TextButton.icon(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          isDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return EditBudgetSheet(
                                              selectedDateTime: _selectedDate,
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 18,
                                      ),
                                      label: BlocBuilder<BudgetCubit, BudgetState>(
                                        builder: (context, state) {
                                          if (state is BudgetWelcome) {
                                            return const Text("Budget kiriting!");
                                          } else if (state is BudgetLoaded) {
                                            BudgetModel budget = state.budgets.last;
                                            return Text("${budget.amount.toStringAsFixed(0)} so'm");
                                          } else {
                                            return const Text("");
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Text("${totalSumPercentage.toStringAsFixed(2)}%")
                              ],
                            ),
                            ProgressBar(
                              totalSumPer: totalSumPercentage,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: p1.maxWidth,
                          height: p1.maxHeight * 0.86,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45),
                            ),
                          ),
                          child: BlocBuilder<ExpenseCubit, ExpenseState>(
                            builder: (context, state) {
                              if (state is ExpenseLoaded) {
                                return ExpenseListView(
                                  expenses: state.expenses,
                                );
                              } else if (state is ExpenseError) {
                                return Center(
                                  child: Text(
                                    state.errorMsg.toString(),
                                    style: GoogleFonts.nunito(),
                                  ),
                                );
                              } else if (state is ExpenseLoading) {
                                return const CircularProgressIndicator();
                              } else {
                                return Center(
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Text(
                                      "Information is not available!",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (context) {
              return const AddExpense();
            },
          );
        },
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
    );
  }
}
