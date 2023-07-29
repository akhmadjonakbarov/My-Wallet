import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Header extends StatefulWidget {
  final Function()? showCalendar;
  final Function()? previousMonth;
  final Function()? nextMonth;
  final Size? size;
  final double totalSum;
  final DateTime selectedDate;

  const Header({
    super.key,
    this.showCalendar,
    this.previousMonth,
    this.nextMonth,
    this.size,
    required this.totalSum,
    required this.selectedDate,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    // final isLastDate = widget.selectedDate.year == DateTime.now().year &&
    //     widget.selectedDate.month == DateTime.now().month;
    final isFirstDate =
        widget.selectedDate.year == 2020 && widget.selectedDate.month == 1;

    return Container(
      height: widget.size!.height * 0.15,
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              widget.showCalendar!();
            },
            child: Text(
              DateFormat("MMMM, y").format(
                widget.selectedDate,
              ),
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isFirstDate ? Colors.grey : Colors.black,
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    widget.previousMonth!();
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                    color: isFirstDate ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${widget.totalSum}",
                    style: GoogleFonts.montserrat(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "so'm",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, height: 0.6),
                  )
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    widget.nextMonth!();
                  },
                  icon: const Icon(
                    Icons.arrow_right,
                    size: 30,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
