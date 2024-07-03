import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

ListView newsList({required var news, required int newsindex}) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: newsindex, //using newsindex ///not working good
      ///there is isues in the data it self can't handle it
      itemBuilder: (context, index) => Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            child: InkWell(
              onTap: () {
                Uri url = Uri.parse(news[index]["url"]);
                launchUrl(url).catchError((e) {
                  print("$e Error");
                });
              },
              child: Column(
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                news[index]["urlToImage"].toString()),
                            fit: BoxFit.cover),
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        news[index]["title"].toString(),
                      ),
                      Center(
                        child: Text(
                          style: const TextStyle(color: Colors.grey),
                          news[index]["publishedAt"].toString(),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
      separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 2,
            color: Color.fromARGB(104, 0, 150, 135),
            endIndent: 9,
            indent: 9,
          ));
}
