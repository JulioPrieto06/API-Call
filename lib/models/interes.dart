// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  List<Datum> data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.titulo,
    required this.fecha,
    required this.contenido,
    required this.visible,
    required this.extracto,
    required this.img,
  });

  String id;
  String titulo;
  DateTime fecha;
  String contenido;
  String visible;
  String extracto;
  String img;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        titulo: json["TITULO"],
        fecha: DateTime.parse(json["FECHA"]),
        contenido: json["CONTENIDO"],
        visible: json["VISIBLE"],
        extracto: json["EXTRACTO"],
        img: json["IMG"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TITULO": titulo,
        "FECHA": fecha.toIso8601String(),
        "CONTENIDO": contenido,
        "VISIBLE": visible,
        "EXTRACTO": extracto,
        "IMG": img,
      };
}
