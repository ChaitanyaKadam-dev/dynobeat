// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyPlayerList {
  final List<MyPlayer> players;
  MyPlayerList({
    required this.players,
  });

  MyPlayerList copyWith({
    List<MyPlayer>? players,
  }) {
    return MyPlayerList(
      players: players ?? this.players,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'players': players.map((x) => x.toMap()).toList(),
    };
  }

  factory MyPlayerList.fromMap(Map<String, dynamic> map) {
    return MyPlayerList(
      players: List<MyPlayer>.from((map['players'] as List<int>).map<MyPlayer>((x) => MyPlayer.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPlayerList.fromJson(String source) => MyPlayerList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyPlayerList(players: $players)';

  @override
  bool operator ==(covariant MyPlayerList other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.players, players);
  }

  @override
  int get hashCode => players.hashCode;
}

class MyPlayer {
  final int id;
  final int order;
  final String name;
  final String tagline;
  final String color;
  final String desc;
  final String url;
  final String category;
  final String icon;
  final String image;
  final String lang;
  MyPlayer({
    required this.id,
    required this.order,
    required this.name,
    required this.tagline,
    required this.color,
    required this.desc,
    required this.url,
    required this.category,
    required this.icon,
    required this.image,
    required this.lang,
  });

  MyPlayer copyWith({
    int? id,
    int? order,
    String? name,
    String? tagline,
    String? color,
    String? desc,
    String? url,
    String? category,
    String? icon,
    String? image,
    String? lang,
  }) {
    return MyPlayer(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      color: color ?? this.color,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      lang: lang ?? this.lang,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order': order,
      'name': name,
      'tagline': tagline,
      'color': color,
      'desc': desc,
      'url': url,
      'category': category,
      'icon': icon,
      'image': image,
      'lang': lang,
    };
  }

  factory MyPlayer.fromMap(Map<String, dynamic> map) {
    return MyPlayer(
      id: map['id'] as int,
      order: map['order'] as int,
      name: map['name'] as String,
      tagline: map['tagline'] as String,
      color: map['color'] as String,
      desc: map['desc'] as String,
      url: map['url'] as String,
      category: map['category'] as String,
      icon: map['icon'] as String,
      image: map['image'] as String,
      lang: map['lang'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPlayer.fromJson(String source) =>
      MyPlayer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyPlayer(id: $id, order: $order, name: $name, tagline: $tagline, color: $color, desc: $desc, url: $url, category: $category, icon: $icon, image: $image, lang: $lang)';
  }

  @override
  bool operator ==(covariant MyPlayer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.order == order &&
        other.name == name &&
        other.tagline == tagline &&
        other.color == color &&
        other.desc == desc &&
        other.url == url &&
        other.category == category &&
        other.icon == icon &&
        other.image == image &&
        other.lang == lang;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        name.hashCode ^
        tagline.hashCode ^
        color.hashCode ^
        desc.hashCode ^
        url.hashCode ^
        category.hashCode ^
        icon.hashCode ^
        image.hashCode ^
        lang.hashCode;
  }
}
