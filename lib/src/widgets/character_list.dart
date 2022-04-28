import 'dart:convert';
import 'package:anime/src/models/character_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/character_screen.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  Map? mapResponse;
  List? listOfCharacters;

  Future fetchCharacters() async {
    http.Response response;
    response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/top/characters'));

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfCharacters = mapResponse!['data'];
      });
    }
  }

  @override
  void initState() {
    fetchCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return listOfCharacters == null
        ? const Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.amber),))
        : Container(
            color: Colors.black,
            child: ListView.builder(
                itemCount: listOfCharacters?.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      color: Colors.black12,
                      child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage(
                                  listOfCharacters![index]['images']['jpg']
                                      ['image_url']),
                            ),
                          ),
                          title: Text(
                            listOfCharacters![index]['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.amber,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CharacterScreen(
                                      character: listOfCharacters![index])),
                            );
                          }),
                    ),
                  );
                }),
          );
  }
}
