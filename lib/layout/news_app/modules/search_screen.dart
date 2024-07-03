import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/news_app/cubit/cubit.dart';
import 'package:to_do_app/layout/news_app/cubit/states.dart';
import 'package:to_do_app/layout/news_app/shared/componants/news_componants.dart';
import 'package:to_do_app/layout/to_do_app/shared/componants/componants.dart';

class SearchTerms extends StatelessWidget {
  const SearchTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                defaultTextFormField(
                    onChange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    hintText: "Search",
                    labelText: "",
                    Icons: Icons.search),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: newsList(
                      news: NewsCubit.get(context).search,
                      newsindex: NewsCubit.get(context).searchIndex),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
