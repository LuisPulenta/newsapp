import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:provider/provider.dart';

class TabsPageScreen extends StatelessWidget {
  const TabsPageScreen({Key? key}) : super(key: key);

//------------------------------------------------------------------------
//------------------------ Pantalla --------------------------------------
//------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

//------------------------------------------------------------------------
//------------------------ class _Paginas --------------------------------
//------------------------------------------------------------------------

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      //physics: BouncingScrollPhysics(),
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

//------------------------------------------------------------------------
//------------------------ class _Navegacion -----------------------------
//------------------------------------------------------------------------

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      selectedItemColor: miTema.colorScheme.secondary,
      onTap: (i) {
        navegacionModel.paginaActual = i;
        final newsServices = Provider.of<NewsService>(context, listen: false);
        newsServices.selectedCategory = newsServices.selectedCategory;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

//------------------------------------------------------------------------
//------------------------ class _NavegacionModel ------------------------
//------------------------------------------------------------------------

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController(initialPage: 0);

  int get paginaActual {
    return _paginaActual;
  }

  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
