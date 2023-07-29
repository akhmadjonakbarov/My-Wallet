// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BudgetModel {
  String id;
  double amount;
  DateTime dateTime;
  BudgetModel({
    required this.id,
    required this.amount,
    required this.dateTime,
  });

  BudgetModel copyWith({
    String? id,
    double? amount,
    DateTime? dateTime,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'] as String,
      amount: map['amount'] as double,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetModel.fromJson(String source) => BudgetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Budget(id: $id, amount: $amount, dateTime: $dateTime)';

  @override
  bool operator ==(covariant BudgetModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.amount == amount && other.dateTime == dateTime;
  }

  @override
  int get hashCode => id.hashCode ^ amount.hashCode ^ dateTime.hashCode;
}
