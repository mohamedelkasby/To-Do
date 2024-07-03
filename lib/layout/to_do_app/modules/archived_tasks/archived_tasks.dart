import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componants/componants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archiveTasks;
        return AppCubit.get(context).archiveTasks.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.archive_outlined,
                      color: Colors.grey,
                      size: 100,
                    ),
                    Text(
                      "there is no tasks yet",
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(child: defualtTaskItem(context, tasks[index], 2));
                },
              );
      },
    );
  }
}
