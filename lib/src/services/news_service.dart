import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = 'a539dfbe34d04659a1a745db8c6c80e9';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business', 'negocios'),
    Category(FontAwesomeIcons.tv, 'entertainment', 'entretenim.'),
    Category(FontAwesomeIcons.addressCard, 'general', 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health', 'salud'),
    Category(FontAwesomeIcons.vials, 'science', 'ciencia'),
    Category(FontAwesomeIcons.volleyball, 'sports', 'deportes'),
    Category(FontAwesomeIcons.memory, 'technology', 'tecnología'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory];

  getTopHeadLines() async {
    final url = Uri.parse('$_urlNews/top-headlines?apiKey=$_apiKey&country=ar');

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url = Uri.parse(
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=ar&category=$category');

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}
