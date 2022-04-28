class CharacterModel {
  //late int mal_id;
  // final String url;
  // "images": {
  // "jpg": {
  // "image_url": "string",
  // "small_image_url": "string"
  // },
  // "webp": {
  // "image_url": "string",
  // "small_image_url": "string"
  // }
  // },
  // final String name;
  // "name": "string",
  // "name_kanji": "string",
  // "nicknames": [
  // "string"
  // ],
  // "favorites": 0,
  // final String about;

   final int albumId;
   final int id;
   final String title;
   final String url;
   final String thumbnailUrl;

  CharacterModel({required this.albumId, required this.id, required this.title,
      required this.url, required this.thumbnailUrl});
  //CharacterModel({required this.url, required this.name, required this.about});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
       return CharacterModel(
        // url: json['url'],
        // name: json['name'],
        // about: json['about']

           albumId: json['albumId'] as int,
           id: json['id'] as int,
           title: json['title'] as String,
           url: json['url'] as String,
           thumbnailUrl: json['thumbnailUrl'] as String

    );
  }
}
