import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componants/componants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;

        return AppCubit.get(context).doneTasks.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done_all,
                      size: 120,
                      color: Colors.grey,
                    ),
                    Text("there is no finished tasks",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey,
                        ))
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
