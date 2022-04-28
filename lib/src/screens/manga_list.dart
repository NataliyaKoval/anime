import 'dart:convert';

import 'package:anime/src/screens/manga_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MangaList extends StatefulWidget {
  const MangaList({Key? key}) : super(key: key);

  @override
  State<MangaList> createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> {
  Map? mapResponse;
  List? listOfManga;

  Future fetchManga() async {
    http.Response response;
    response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/manga'));

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfManga = mapResponse!['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchManga();
  }

  @override
  Widget build(BuildContext context) {
    return listOfManga == null
        ? const Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.amber),))
        : Container(
            color: Colors.black,
            child: GridView.builder(
              itemCount: listOfManga?.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: (1 / 1.4),
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MangaScreen(manga: listOfManga![index]),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.black,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      listOfManga?[index]['images']['jpg']['image_url'],
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                );
              },
            ),
          );
  }
}
