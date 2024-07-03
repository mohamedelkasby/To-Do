import 'package:flutter/material.dart';

import 'package:to_do_app/layout/news_app/news_layout.dart';
import 'package:to_do_app/layout/to_do_app/home_layout.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 20.5,
        children: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeLayout(),
                )),
            child: Container(
              color: Colors.blue,
              child: const Center(
                  child: Text(
                "To Do App",
                style: TextStyle(color: Colors.white, fontSize: 35),
              )),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsLayout(),
                )),
            child: Container(
              color: Colors.teal,
              child: const Center(
                  child: Text("News App",
                      style: TextStyle(color: Colors.white, fontSize: 35))),
            ),
          )
        ],
      ),
    );
  }
}
