import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'a539dfbe34d04659a1a745db8c6c80e9';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    getTopHeadLines();
  }

  getTopHeadLines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar');

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
