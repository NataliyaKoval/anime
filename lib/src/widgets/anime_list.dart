import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/anime_screen.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  Map? mapResponse;
  List? listOfAnime;

  Future fetchAnime() async {
    http.Response response;
    response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfAnime = mapResponse!['data'];
      });
    }
  }

  @override
  void initState() {
    fetchAnime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return listOfAnime == null
        ? const Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.amber),))
        : Container(
            color: Colors.black,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Top Anime',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listOfAnime?.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AnimeScreen(anime: listOfAnime![index]),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Image.network(
                                      listOfAnime![index]['images']
                                      ['jpg']['image_url'],
                                    height: 320,
                                  ),
                                  Positioned(
                                    width: 200,
                                    top: 10,
                                    left: 10,
                                    child: Text(
                                      listOfAnime![index]['title'],
                                      //softWrap: true,
                                      style: TextStyle(
                                        backgroundColor: Colors.black.withOpacity(.7),
                                        color: Colors.amber,
                                        fontSize: 20,

                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }
}
