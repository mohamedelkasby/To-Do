import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/layout/to_do_app/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_tasks/done_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  bool doneValidate = false;
  bool archiveValidate = false;
  var currIndex = 0;
  List currScreen = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks()
  ];
  List currTitle = ["New Tasks", "Finished Tasks", "Archived Tasks"];

  void changeIndex(int index) {
    currIndex = index;
    emit(ChangeNavBarIcon());
  }
  ////////////////

  late Database dataBase;
  createDataBase() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT , date TEXT  , time TEXT, status TEXT)")
            .then((value) {})
            .catchError((error) {
          print("Error handled when create the table$error");
        });
      },
      onOpen: (db) {
        //db.rawDelete("DELETE FROM tasks");
        getFromDataBase(db);
        // print("table obened");
        emit(GetDataBaseState());
      },
    ).then((value) {
      dataBase = value;
      // print("DB Created");
      emit(CreateDataBaseState());
    });
  }

  insertToDataBase(
      {required String title,
      required String date,
      required String time}) async {
    await dataBase.transaction((txn) async {
      emit(InsertDataBaseState());
      await txn
          .rawInsert(
              "INSERT INTO tasks(title , date, time, status) VALUES('$title','$date','$time', 'new')")
          .then((value) {
        //print("$value inserted successfuly");

        getFromDataBase(dataBase).then((value) {
          emit(GetDataBaseState());
        });
      }).catchError((onError) {
        print("handeled error when inserting Database");
      });
    });
  }

  getFromDataBase(Database dataBase) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    dataBase.rawQuery("SELECT * FROM tasks").then((value) {
      for (var element in value) {
        print(element["status"]);
        if (element["status"] == "new") {
          newTasks.add(element);
        } else if (element["status"] == "archive") {
          archiveTasks.add(element);
        } else {
          doneTasks.add(element);
        }
      }
      emit(DataBaseLoadingState());
    });
  }

  void UpdateFromDataBase({required String status, required int id}) {
    dataBase.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = $id', [status]).then((value) {
      getFromDataBase(dataBase);
      emit(UpdateDataBaseState());
    });
  }

  void DleteFromDataBase(int id) {
    dataBase.rawDelete('DELETE FROM tasks WHERE id = $id').then((value) {
      getFromDataBase(dataBase);
      emit(DeleteDataBaseState());
    });
  }
}
