import 'package:flutter/material.dart';
import 'package:to_do_app/layout/to_do_app/shared/cubit/cubit.dart';

Widget defaultTextFormField({
  TextEditingController? controller,
  required String hintText,
  required String labelText,
  IconData? Icons,
  var validate,
  var onTap,
  var onChange,
  TextInputType? keyboardType,
}) {
  return TextFormField(
      onChanged: onChange,
      keyboardType: TextInputType.name,
      controller: controller,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Icon(
            Icons,
          )));
}

Widget defualtTaskItem(context, Map model, directionValue) {
  return Dismissible(
    direction: DismissDirection.values[directionValue],
    background: Container(
      padding: const EdgeInsets.only(left: 10),
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.archive,
            color: Colors.green[200],
            size: 40,
          ),
          const Text(
            "Move to archive",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    ),
    secondaryBackground: Container(
      padding: const EdgeInsets.only(right: 10),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Move to trash",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Icon(
            Icons.delete,
            color: Colors.red[200],
            size: 40,
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      if (direction == DismissDirection.endToStart) {
        AppCubit.get(context).DleteFromDataBase(model["id"]);
      } else if (direction == DismissDirection.startToEnd) {
        AppCubit.get(context)
            .UpdateFromDataBase(status: "archive", id: model["id"]);
      }
    },
    key: Key(model["id"].toString()),
    child: Row(children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: CircleAvatar(
          //backgroundColor: Colors.blue,
          radius: 42.0,
          child: Text(model["time"],
              style: const TextStyle(
                fontSize: 18,
              )),
        ),
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model["title"],
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              model["date"],
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      const SizedBox(
        width: 30,
      ),
      IconButton(
          onPressed: () {
            AppCubit.get(context).doneValidate =
                !AppCubit.get(context).doneValidate;
            AppCubit.get(context).UpdateFromDataBase(
                status: AppCubit.get(context).doneValidate ? "done" : "new",
                id: model["id"]);
            print(model["status"]);
          },
          icon: AppCubit.get(context).doneValidate
              ? const Icon(
                  Icons.check_box_outlined,
                  color: Colors.green,
                )
              : const Icon(Icons.check_box_outline_blank)),
      IconButton(
          onPressed: () {
            AppCubit.get(context).archiveValidate =
                !AppCubit.get(context).archiveValidate;
            AppCubit.get(context).UpdateFromDataBase(
                status:
                    AppCubit.get(context).archiveValidate ? "archive" : "new",
                id: model["id"]);
          },
          icon: AppCubit.get(context).archiveValidate
              ? const Icon(
                  Icons.archive_outlined,
                  color: Colors.green,
                )
              : const Icon(Icons.archive_outlined)),
      const SizedBox(
        width: 10,
      )
    ]),
  );
}
