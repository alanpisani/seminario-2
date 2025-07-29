import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final prefs = await SharedPreferences.getInstance();
  final idUsuario = prefs.getInt('id_usuario') ?? 0;

  runApp(MyApp(conectado: idUsuario != 0));
}

class MyApp extends StatelessWidget {
  final bool conectado;
  final Color colorPrincipal = const Color.fromARGB(255, 39, 1, 46);
  const MyApp({super.key, required this.conectado});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seminario 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorPrincipal,
          brightness: Brightness.dark,
          primary: colorPrincipal,
          onSecondary: const Color.fromARGB(255, 113, 29, 128)),
        scaffoldBackgroundColor: colorPrincipal,
      ),
      routes: routes,
      initialRoute: conectado ? '/home' : '/intro',
    );
  }
}