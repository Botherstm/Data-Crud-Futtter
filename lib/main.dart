import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/http_provider.dart';
// import './pages/home_stateful.dart';
// import './pages/home_provider.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: HomeStateful(),
        // mengaktifkan providernya;
        home: ChangeNotifierProvider(
          create: (context) => HttpProvider(),
          // child: HomeProvider(),
          child: GetData(),

          // ),
        ));
  }
}
