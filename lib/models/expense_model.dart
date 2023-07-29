// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExpenseModel {
  String id;
  String title;
  double amount;
  double price;
  int iconData;
  String iconFont;
  String iconPackage;
  DateTime dateTime;
  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.price,
    required this.iconData,
    required this.iconFont,
    required this.iconPackage,
    required this.dateTime,
  });

  ExpenseModel copyWith({
    String? id,
    String? title,
    double? amount,
    double? price,
    int? iconData,
    String? iconFont,
    String? iconPackage,
    DateTime? dateTime,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      iconData: iconData ?? this.iconData,
      iconFont: iconFont ?? this.iconFont,
      iconPackage: iconPackage ?? this.iconPackage,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'amount': amount,
      'price': price,
      'iconData': iconData,
      'iconFont': iconFont,
      'iconPackage': iconPackage,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: map['amount'] as double,
      price: map['price'] as double,
      iconData: map['iconData'] as int,
      iconFont: map['iconFont'] as String,
      iconPackage: map['iconPackage'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) => ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, price: $price, iconData: $iconData, iconFont: $iconFont, iconPackage: $iconPackage, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant ExpenseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.amount == amount &&
        other.price == price &&
        other.iconData == iconData &&
        other.iconFont == iconFont &&
        other.iconPackage == iconPackage &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        amount.hashCode ^
        price.hashCode ^
        iconData.hashCode ^
        iconFont.hashCode ^
        iconPackage.hashCode ^
        dateTime.hashCode;
  }
}
