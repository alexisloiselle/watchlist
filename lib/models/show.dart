import 'dart:math';

import 'package:watchlist/models/content.dart';
import 'package:watchlist/extensions/string.dart';
import 'package:watchlist/extensions/object.dart';

class Show implements Content {
  final String title;
  final String year;
  final double rating;
  final DateTime addedOn;
  final DateTime watchedOn;

  Show({
    this.title,
    this.year,
    this.rating,
    this.addedOn,
    this.watchedOn,
  });

  factory Show.fromTmdb(Map<String, dynamic> json) {
    final firstAirDate = json['first_air_date'].toString();
    final year = firstAirDate.substring(0, min(firstAirDate.length, 4));

    return Show(
      title: json['name'],
      year: year,
      rating: json['vote_average'].toDouble() * 10,
    );
  }

  static List<Show> arrayFromTmdb(Map<String, dynamic> json) {
    List<Show> shows = List();
    final results = json['results'];
    final endRange = results.length < 3 ? results.length : 3;

    for (final result in results.getRange(0, endRange)) {
      shows.add(Show.fromTmdb(result));
    }

    return shows;
  }

  static Show fromSheets(List<Object> properties) {
    return Show(
      title: properties[1].cast<String>(),
      year: properties[2].cast<String>(),
      rating: double.tryParse(properties[3].cast<String>().asNotEmpty()) ?? 0,
      addedOn: DateTime.tryParse(properties[4].cast<String>()),
      watchedOn: properties.length < 6
          ? null
          : DateTime.tryParse(properties[5].cast<String>()),
    );
  }

  @override
  List<List<String>> toNewValues() {
    return List.from([
      [
        "show",
        this.title,
        this.year.toString(),
        this.rating.toString(),
        DateTime.now().toIso8601String(),
      ],
    ]);
  }
}