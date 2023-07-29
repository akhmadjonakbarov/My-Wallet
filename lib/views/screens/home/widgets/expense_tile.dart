import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/logic/expense_cubit/expense_cubit.dart';
import '../../../../models/expense_model.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.expense,
  });

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you want to delete it?",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {
                          BlocProvider.of<ExpenseCubit>(context).delete(
                            expense: expense,
                          );
                          Navigator.of(context).pop();
                        },
                        child: const Text("Yes"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          IconData(
            expense.iconData,
            fontFamily: expense.iconFont,
            fontPackage: expense.iconPackage,
          ),
        ),
      ),
      title: Text(
        expense.title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        DateFormat("d MMMM, y").format(
          DateTime.now(),
        ),
      ),
      trailing: Text("${expense.price} so'm"),
    );
  }
}
