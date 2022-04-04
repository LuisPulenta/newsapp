import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:provider/provider.dart';

class TabsPageScreen extends StatelessWidget {
  const TabsPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      //physics: BouncingScrollPhysics(),
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Container(
          color: Colors.green,
        ),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = PageController(initialPage: 1);

  int get paginaActual {
    return _paginaActual;
  }

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController {
    return _pageController;
  }
}
