import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/news_app/cubit/cubit.dart';
import 'package:to_do_app/layout/news_app/cubit/states.dart';

import 'modules/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          endDrawer: Drawer(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  color: Colors.teal,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.transparent,
                          shadows: [
                            Shadow(offset: Offset(0, -7), color: Colors.white)
                          ],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Setting",
                          style: TextStyle(
                              color: Colors.transparent,
                              shadows: [
                                Shadow(
                                    offset: Offset(0, -7), color: Colors.white)
                              ],
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.6,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("${cubit.appBarList[cubit.currIndex]} News"),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchTerms()));
                  }),
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
          body: cubit.bodyList[cubit.currIndex],
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              currentIndex: cubit.currIndex,
              onTap: (index) {
                NewsCubit.get(context).bottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.business_outlined), label: "business"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sports_basketball), label: "sport"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.science), label: "science"),
              ]),
        );
      },
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           if (query.isEmpty) {
//             close(context, null);
//           }
//           query = '';
//         },
//         icon: Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List matchQuery = [];
//     List searchTerms = NewsCubit.get(context).getSearch as List;
//     for (var search in searchTerms) {
//       if (search
//           .toLowerCase()
//           .contains(NewsCubit.get(context).getSearch(query.toLowerCase()))) {
//         matchQuery.add(search);
//       }
//     }
//     return newsList(news: matchQuery, newsindex: matchQuery.length);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     List<String> searchTerms = [];
//     DioHelper.getData(url: "v2/everything", quary: {
//       "q": "us",
//       "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
//     }).then((value) {
//       searchTerms = value.data["articles"];

//       for (var search in searchTerms) {
//         if (search.toLowerCase().contains(query.toLowerCase())) {
//           matchQuery.add(search);
//         }
//       }
//     });
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
// }
