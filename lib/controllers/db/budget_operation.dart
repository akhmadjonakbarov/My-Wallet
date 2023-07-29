import 'dart:developer';

import 'package:my_wallet/controllers/db/db_helper.dart';

import '../../models/budget_model.dart';

class BudgetOperation {
  BudgetOperation? bankOperation;
  static DBHelper dbHelperProvider = DBHelper.instance;
  static const String _tableName = "budgets";

  static Future getData() async {
    final sqlDB = await dbHelperProvider.database;
    List<Map<String, dynamic>> datas = await sqlDB.query(
      _tableName,
      orderBy: "id",
    );
    log("Data was got successfully");
    return datas.map((data) => BudgetModel.fromMap(data)).toList();
  }

  static Future<void> insertData({required Map<String, dynamic> data}) async {
    final sqlDB = await dbHelperProvider.database;
    if (data.isNotEmpty) {
      await sqlDB.insert(_tableName, data);
      log("Data was added successfully");
    }
  }

  static Future<int> updateData({required BudgetModel budget}) async {
    final sqlDB = await dbHelperProvider.database;
    int res = await sqlDB.update(
      _tableName,
      budget.toMap(),
      where: "id = ?",
      whereArgs: [budget.id],
    );
    log("Data was updated successfully");
    return res;
  }

  static Future<void> deleteData({required BudgetModel budget}) async {
    // this method delete data
    final sqlDB = await dbHelperProvider.database;
    sqlDB.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [budget.id],
    );
    log("Data was deleted successfully");
  }
}
