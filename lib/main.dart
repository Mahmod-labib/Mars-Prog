import 'package:flutter/material.dart';
import 'package:untitled6/ui/screens/home-page.dart';
import 'package:untitled6/utils/material-theme/color_schemes.g.dart';
main(){
  runApp(const MyAPP());
}
class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: lightColorScheme,

      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme
      ),
      home: const HomePage(),
    );
  }
}
