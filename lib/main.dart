import 'package:cipers_cluster/ui/home/home_page.dart';
import 'package:cipers_cluster/util/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  var bindings = AppBindings();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'NoteKeeper',
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => HomePage(), binding: bindings),
          // GetPage(name: '/login', page: () => LoginScreen(), binding: bindings),
          // GetPage(name: '/home', page: () => BottomNav(), binding: bindings),
          // GetPage(name: '/', page: () => LandingScreen(), binding: bindings),
        ],
      );
}
