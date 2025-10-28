import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/pages/tabs_page.dart';
import 'src/services/news_service.dart';
import 'src/theme/tema.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: miTema,
        home: const TabsPageScreen(),
      ),
    );
  }
}
