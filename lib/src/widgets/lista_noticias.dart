import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article>? noticias;

  const ListaNoticias(this.noticias, {Key? key}) : super(key: key);

//------------------------- PANTALLA ---------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: noticias?.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(
          noticia: noticias![index],
          index: index,
        );
      },
    );
  }
}

//------------------------- _Noticia ---------------------------------
class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(noticia),
      child: Column(
        children: [
          _TarjetaTopBar(
            noticia: noticia,
            index: index,
          ),
          _TarjetaTitulo(
            noticia: noticia,
          ),
          _TarjetaImagen(
            noticia: noticia,
          ),
          _TarjetaBody(
            noticia: noticia,
          ),
          const SizedBox(
            height: 10,
          ),
          //_TarjetaBotones(),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

//------------------------- _TarjetaTopBar ---------------------------------
class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ',
              style: TextStyle(color: miTema.colorScheme.secondary)),
          Text('${noticia.source.name}. '),
        ],
      ),
    );
  }
}

//------------------------- _TarjetaTitulo ---------------------------------
class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}

//------------------------- _TarjetaImagen ---------------------------------
class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Container(
          child: (noticia.urlToImage != null)
              ? FadeInImage(
                  image: NetworkImage(noticia.urlToImage!),
                  placeholder: const AssetImage('assets/giphy.gif'),
                )
              : Container(),
          //const Image(image: AssetImage('assets/no-image.png')),
        ),
      ),
    );
  }
}

//------------------------- _TarjetaBody ---------------------------------
class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(noticia.description == null ? '' : noticia.description!,
          style: const TextStyle(fontSize: 14)),
    );
  }
}

//------------------------- _TarjetaBotones ---------------------------------
class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: miTema.colorScheme.secondary,
          child: const Icon(Icons.star_border),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(width: 10),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          child: const Icon(Icons.more),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ],
    );
  }
}

void _launchURL(Article noticia) async {
  if (!await launch(noticia.url)) {
    throw 'No se puede leer la noticia';
  }
}
