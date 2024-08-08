

import 'dart:convert';

Blogmodel blogmodelFromJson(String str) => Blogmodel.fromJson(json.decode(str));

String blogmodelToJson(Blogmodel data) => json.encode(data.toJson());

class Blogmodel {
    String id;
    String imageUrl;
    String title;

    Blogmodel({
        required this.id,
        required this.imageUrl,
        required this.title,
    });

    factory Blogmodel.fromJson(Map<String, dynamic> json) => Blogmodel(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
    };
}
