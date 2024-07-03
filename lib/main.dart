import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/news_app/cubit/cubit.dart';
import 'package:to_do_app/layout/news_app/cubit/states.dart';
import 'package:to_do_app/layout/news_app/shared/network/dio_helper.dart';

import 'layout/bloc_observer.dart';
import 'layout/choose.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) => {},
        builder: (context, state) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.teal,
            appBarTheme: AppBarTheme(
              // titleTextStyle: TextStyle(color: Colors.teal),
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.teal[700]),
              color: Colors.teal,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.grey),
          ),
          darkTheme: ThemeData(
              primaryColorDark: Colors.teal[700],
              primarySwatch: Colors.teal,
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.teal[900],
              ),
              inputDecorationTheme: InputDecorationTheme(
                  prefixIconColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10)),
                  iconColor: Colors.white,
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 128, 203, 196),
                      )),
                  fillColor: Colors.teal[900],
                  // filled: true,
                  hintStyle: TextStyle(color: Colors.grey[400])),
              bottomSheetTheme: BottomSheetThemeData(
                  modalBackgroundColor: Colors.teal[800],
                  backgroundColor: Colors.red),
              textTheme: const TextTheme(
                  bodyMedium: TextStyle(color: Colors.white),
                  titleMedium: TextStyle(color: Colors.white)),
              cardTheme: CardTheme(color: Colors.teal[900]),
              drawerTheme: DrawerThemeData(backgroundColor: Colors.teal[900]),
              scaffoldBackgroundColor: Colors.teal[900],
              appBarTheme: AppBarTheme(
                color: Colors.teal[900],
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Color.fromARGB(255, 0, 58, 50)),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.teal[400]),
              iconTheme: const IconThemeData(color: Colors.white),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 30.5,
                  backgroundColor: Colors.teal[900],
                  selectedItemColor: Colors.teal[300],
                  unselectedItemColor: Colors.grey[600])),
          themeMode:
              NewsCubit.get(context).light ? ThemeMode.light : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: const Choose(),
        ),
      ),
    );
  }
}
