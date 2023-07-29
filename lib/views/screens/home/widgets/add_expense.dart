import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:intl/intl.dart';

import '../../../../controllers/logic/expense_cubit/expense_cubit.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime _selectedDateOfExpense = DateTime.now();

  final dataFormKey = GlobalKey<FormState>();
  String title = "";
  double amount = 0.0;
  double price = 0.0;
  IconData iconData = CupertinoIcons.bag;
  void _enterData() {
    bool isValid = dataFormKey.currentState!.validate();
    if (isValid) {
      dataFormKey.currentState!.save();
      BlocProvider.of<ExpenseCubit>(context).add(
        title: title,
        price: price,
        amount: amount,
        iconData: iconData,
        iconFont: iconData.fontFamily!,
        iconPackage: iconData.fontPackage!,
        dateTime: _selectedDateOfExpense,
      );
      Navigator.of(context).pop();
    }
  }

  _pickIcon() async {
    iconData = (await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [
        IconPack.cupertino,
      ],
    ))!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Form(
            key: dataFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                  onChanged: (inputTitle) {
                    setState(() {
                      title = inputTitle;
                    });
                  },
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Amount",
                  ),
                  onChanged: (inputAmount) {
                    setState(() {
                      amount = double.parse(inputAmount);
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Price",
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      price = double.parse(newValue);
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date: ${DateFormat("d MMMM, y").format(
                _selectedDateOfExpense,
              )}"),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: _selectedDateOfExpense,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2099),
                  ).then((value) {
                    setState(() {
                      _selectedDateOfExpense = value!;
                    });
                  });
                },
                child: const Text("Select Date"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Icon:",
              ),
              IconButton(
                onPressed: () {
                  _pickIcon();
                },
                icon: Icon(iconData),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _enterData();
                },
                child: const Text(
                  "Enter",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
