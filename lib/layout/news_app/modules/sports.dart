import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/news_app/shared/componants/news_componants.dart';
import 'package:to_do_app/layout/news_app/cubit/states.dart';

import '../cubit/cubit.dart';

class Sports extends StatelessWidget {
  const Sports({super.key});

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).sports;
    int index = NewsCubit.get(context).sporIndex;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) => list.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : newsList(newsindex: index, news: list),
    );
  }
}
