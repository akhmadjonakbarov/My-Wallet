import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  double totalSumPer;
  ProgressBar({
    super.key,
    required this.totalSumPer,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 5,
      decoration: BoxDecoration(
        color: const Color(0xFFC1C4D7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        heightFactor: 2,
        widthFactor: widget.totalSumPer / 100,
        child: Container(
          height: 5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(
                      0.3,
                    ),
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor,
                blurRadius: 10,
                spreadRadius: -5,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
