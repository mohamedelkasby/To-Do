import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/layout/to_do_app/shared/cubit/states.dart';
import '../../shared/componants/componants.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return AppCubit.get(context).newTasks.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.line_style,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      "there is no tasks yet",
                      style: TextStyle(fontSize: 30, color: Colors.grey),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(child: defualtTaskItem(context, tasks[index], 1));
                },
              );
      },
    );
  }
}
