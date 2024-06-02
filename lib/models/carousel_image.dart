// To parse this JSON data, do
//
//     final imageTest = imageTestFromJson(jsonString);

import 'dart:convert';

List<ImageTest> imageTestFromJson(String str) => List<ImageTest>.from(json.decode(str).map((x) => ImageTest.fromJson(x)));

String imageTestToJson(List<ImageTest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageTest {
    String id;
    String url;
    int width;
    int height;

    ImageTest({
        required this.id,
        required this.url,
        required this.width,
        required this.height,
    });

    ImageTest copyWith({
        String? id,
        String? url,
        int? width,
        int? height,
    }) => 
        ImageTest(
            id: id ?? this.id,
            url: url ?? this.url,
            width: width ?? this.width,
            height: height ?? this.height,
        );

    factory ImageTest.fromJson(Map<String, dynamic> json) => ImageTest(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
    };
}
