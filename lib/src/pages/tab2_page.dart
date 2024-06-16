import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
//--------------------------- PAGINA ----------------------------------
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _ListaCategorias(),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
            child: (newsService
                    .categoryArticles[newsService.selectedCategory]!.isEmpty)
                ? Center(
                    child: CircularProgressIndicator(
                        color: miTema.colorScheme.secondary),
                  )
                : ListaNoticias(newsService.getArticulosCategoriaSeleccionada),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//--------------------------- _ListaCategorias -----------------------------
class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final cName = categories[index].name2;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categories[index]),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            );
          }),
    );
  }
}

//--------------------------- _CategoryButton -----------------------------
class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            categoria.icon,
            color: newsService.selectedCategory == categoria.name
                ? miTema.colorScheme.secondary
                : Colors.black54,
          )),
    );
  }
}
