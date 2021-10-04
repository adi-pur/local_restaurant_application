import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_restaurant_application/shared/shared.dart';
import 'package:local_restaurant_application/ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Restaurant Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          backgroundColor: backgroundColor,
          scaffoldBackgroundColor: backgroundColor),
      initialRoute: WrapperPage.routeName,
      routes: {
        WrapperPage.routeName: (context) => WrapperPage(),
        DetailPage.routeName: (context) => DetailPage(
            id: ModalRoute.of(context)?.settings.arguments as String),
        SearchPage.routeName: (context) => SearchPage(
            query: ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}
