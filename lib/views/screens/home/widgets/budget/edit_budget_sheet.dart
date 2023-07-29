import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../controllers/logic/budget_cubit/budget_cubit.dart';

class EditBudgetSheet extends StatefulWidget {
  final DateTime selectedDateTime;
  const EditBudgetSheet({
    super.key,
    required this.selectedDateTime,
  });

  @override
  State<EditBudgetSheet> createState() => _EditBudgetSheetState();
}

class _EditBudgetSheetState extends State<EditBudgetSheet> {
  final bankFormKey = GlobalKey<FormState>();

  double bank = 0.0;

  void _submit({required BuildContext context}) {
    bool isValid = bankFormKey.currentState!.validate();
    if (isValid) {
      BlocProvider.of<BudgetCubit>(context).add(
        value: bank,
        dateTime: widget.selectedDateTime,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Form(
        key: bankFormKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(),
              keyboardType: TextInputType.number,
              onChanged: (inputBank) {
                setState(() {
                  bank = double.parse(inputBank);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submit(context: context);
                  },
                  child: const Text("Enter"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
