import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';
import '../widgets/lista_noticias.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

//--------------------------- PAGINA ----------------------------------
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : Center(child: ListaNoticias(newsService.headlines)),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
