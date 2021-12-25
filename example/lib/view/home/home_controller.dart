import 'dart:convert';
import 'package:example/model/user_data.dart';
import 'package:example/view/dashboard/dashboard_view.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  List<Users> userData = [];
  String path = "";
  late Database database;
  late Users dashboardData;

  Future<void> createInstance() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'users.db');
    // open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, atype TEXT, gender TEXT, age Text)');
    });
    update();
  }

  void getData() {
    String response =
        '{"users":[{"name":"Krishna","id":"1","atype":"Permanent"},{"name":"Sameera","id":"2","atype":"Permanent"},{"name":"Radhika","id":"3","atype":"Permanent"},{"name":"Yogesh","id":"4","atype":"Permanent"},{"name":"Radhe","id":"5","atype":"Permanent"},{"name":"Anshu","id":"6","atype":"Permanent"},{"name":"Balay","id":"7","atype":"Permanent"},{"name":"Julie","id":"8","atype":"Permanent"},{"name":"Swaminathan","id":"9","atype":"Permanent"},{"name":"Charandeep","id":"10","atype":"Permanent"}]}';
    UserData data = UserData.fromJson(jsonDecode(response));
    createDataBase(data.users);
    update();
  }

  Future<void> createDataBase(List<Users> users) async {
    // Insert some records in a transaction

    for (Users objUser in users) {
      int existUserID = 0;
      List<Map> existUser = await database
          .rawQuery("Select id from Users WHERE id = " + objUser.id);
      if (existUser.isNotEmpty) {
        existUserID = existUser.first['id'] ?? 0;
      }
      if (existUserID != 0) {
        await database.rawUpdate(
            'UPDATE Users SET name = ?, atype = ? WHERE id = ?',
            [objUser.name, objUser.atype, objUser.id]);
      } else {
        await database.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO Users(id, name, atype,age,gender) VALUES(' +
                  objUser.id +
                  ', "' +
                  objUser.name +
                  '", "' +
                  objUser.atype +
                  '", "", "")');
        });

      }
    }
    // int id1 = await txn.rawInsert(
    //     'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
    // print('inserted1: $id1');

    // Get the records
    List<Map> listUsers = await database.rawQuery('SELECT * FROM Users');
    userData = convertIntoList(listUsers: listUsers);

    update();
  }

  List<Users> convertIntoList({required List<Map> listUsers}) {
    // Convert the List<Map<String, dynamic> into a List<Recipe>.
    return List.generate(listUsers.length, (i) {
      return Users(
        id: listUsers[i]['id'].toString(),
        name: listUsers[i]['name'].toString(),
        atype: listUsers[i]['atype'].toString(),
        age: listUsers[i]['age'].toString(),
        gender: listUsers[i]['gender'].toString(),
      );
    });
  }

  Future<void> enterDetails(
      {String gender = "", String age = "", String id = "0"}) async {
    await database.rawUpdate(
        'UPDATE Users SET gender = ?, age = ? WHERE id = ?', [gender, age, id]);
    List<Map> existUser =
        await database.rawQuery("SELECT * FROM Users WHERE id = " + id);
    List<Map> listUsers = await database.rawQuery('SELECT * FROM Users');
    userData = convertIntoList(listUsers: listUsers);
    dashboardData = convertIntoList(listUsers: existUser).first;
    Get.to(DashboardView(data: dashboardData));
    update();
  }

  Future<void> removeDetails({String id = "0"}) async {
    await database.rawUpdate(
        'UPDATE Users SET gender = ?, age = ? WHERE id = ?', ["", "", id]);
    List<Map> listUsers = await database.rawQuery('SELECT * FROM Users');
    userData = convertIntoList(listUsers: listUsers);
    Get.back();
    update();
  }
}
