
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/layout/to_do_app/shared/componants/componants.dart';
import 'package:to_do_app/layout/to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/layout/to_do_app/shared/cubit/states.dart';
import '../news_app/cubit/cubit.dart';


class HomeLayout extends StatelessWidget {
  // @override
  // void initState() {
  //   super.initState();
  //   createDataBase();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var statusController = TextEditingController();

  HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          if (cubit.currIndex == 1) {
            cubit.doneValidate = true;
            cubit.archiveValidate = false;
          } else if (cubit.currIndex == 2) {
            cubit.archiveValidate = true;
            cubit.doneValidate = false;
          } else {
            cubit.archiveValidate = false;
            cubit.doneValidate = false;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.currTitle[cubit.currIndex],
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      NewsCubit.get(context).light
                          ? Icons.brightness_6_outlined
                          : Icons.brightness_4_outlined,
                      color: NewsCubit.get(context).light
                          ? Colors.black
                          : Colors.white,
                    ),
                    onPressed: () {
                      NewsCubit.get(context).LightDarkButton();
                    })
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                    //backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    context: context,
                    builder: (ctx) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              top: 20,
                              left: 8,
                              right: 8),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: titleController,
                                    Icons: Icons.title,
                                    hintText: "Title of the note",
                                    labelText: "Title",
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return "title must be not empty";
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultTextFormField(
                                    keyboardType: TextInputType.none,
                                    controller: dateController,
                                    Icons: Icons.calendar_month_outlined,
                                    hintText: "Enter the date",
                                    labelText: "Date",
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse("2030-11-22"))
                                          .then((value) => dateController.text =
                                              DateFormat.yMEd().format(value!));
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return "Date must be not empty";
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultTextFormField(
                                    keyboardType: TextInputType.none,
                                    controller: timeController,
                                    Icons: Icons.watch_later_outlined,
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text =
                                            value?.format(context) as String;
                                      });
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return "Time must be not empty";
                                      }
                                      return null;
                                    },
                                    hintText: "Enter the Time",
                                    labelText: "Time"),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        onPressed: () {
                                          // setState(() {
                                          if (formkey.currentState!
                                              .validate()) {
                                            cubit
                                                .insertToDataBase(
                                                    title: titleController.text,
                                                    date: dateController.text,
                                                    time: timeController.text)
                                                .then((value) {
                                              Navigator.pop(context);
                                              titleController.text = "";
                                              dateController.text = "";
                                              timeController.text = "";
                                            });
                                          }
                                          // });
                                        },
                                        child: const Text("add"))),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currIndex,
              iconSize: 30,
              showUnselectedLabels: false,
              onTap: (index) => //setState(() {
                  cubit.changeIndex(index), //currIndex = index;
              // }),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.line_weight_sharp),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.task_alt), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archived"),
              ],
            ),
            body: state == DataBaseLoadingState()
                ? const Center(child: CircularProgressIndicator())
                : cubit.currScreen[cubit.currIndex],
          );
        },
      ),
    );
  }
}
