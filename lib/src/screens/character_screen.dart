import 'package:flutter/material.dart';

class CharacterScreen extends StatelessWidget {
  final Map character;

  const CharacterScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  character['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.amber,
                  ),
                ),
              ),
              Image.network(character['images']['jpg']['image_url']),
              SizedBox(height: 16,),
              Text(character['about'], style: TextStyle(color: Colors.white,),),
            ],
          ),
        ),
      ),
    );
  }
}
