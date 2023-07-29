import 'dart:developer';

import '../../models/expense_model.dart';
import 'db_helper.dart';

class ExpenseOperation {
  ExpenseOperation? expenseOperation;
  static DBHelper dbHelperProvider = DBHelper.instance;
  static const String _tableName = "expenses";

  static Future getData() async {
    // this method gets data
    final sqlDB = await dbHelperProvider.database;
    List<Map<String, dynamic>> datas = await sqlDB.query(_tableName, orderBy: "id");
    return datas.map((data) => ExpenseModel.fromMap(data)).toList();
  }

  static Future<void> insertData({required Map<String, dynamic> data}) async {
    // this method enters data
    final sqlDB = await dbHelperProvider.database;
    if (data.isNotEmpty) {
      await sqlDB.insert(_tableName, data);
      log("Data was added successfully");
    }
  }

  static Future<int> updateData({required ExpenseModel expense}) async {
    // this method update data
    final sqlDB = await dbHelperProvider.database;
    int res = await sqlDB.update(
      _tableName,
      expense.toMap(),
      where: "id = ?",
      whereArgs: [expense.id],
    );
    log("Data was updated successfully");
    return res;
  }

  static Future<void> deleteData({required ExpenseModel expense}) async {
    // this method delete data
    final sqlDB = await dbHelperProvider.database;
    sqlDB.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [expense.id],
    );
    log("Data was deleted successfully");
  }
}
