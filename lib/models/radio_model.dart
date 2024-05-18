import 'dart:convert';
import 'package:http/http.dart' as http;

class RadioStation {
  final int id;
  final String name;
  final String url;
  final String recentDate;

  RadioStation(
      {required this.id,
      required this.name,
      required this.url,
      required this.recentDate});

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      recentDate: json['recent_date'],
    );
  }
}

class RadioService {
  static const String apiUrl =
      'https://mp3quran.net/api/v3/radios?language=eng';

  Future<List<RadioStation>> fetchRadioStations() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['radios'];
      return data.map((radio) => RadioStation.fromJson(radio)).toList();
    } else {
      throw Exception('Failed to load radio stations');
    }
  }
}
