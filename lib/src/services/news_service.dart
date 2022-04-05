import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'a539dfbe34d04659a1a745db8c6c80e9';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory];

  getTopHeadLines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar');

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      return categoryArticles[category];
    }

    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar&category=$category');

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}
