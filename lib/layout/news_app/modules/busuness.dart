import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/news_app/cubit/cubit.dart';
import 'package:to_do_app/layout/news_app/cubit/states.dart';

import '../shared/componants/news_componants.dart';

class Business extends StatelessWidget {
  const Business({super.key});

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).business;
    int index = NewsCubit.get(context).bussIndex;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) => list.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : newsList(newsindex: index, news: list),
    );
  }
}
