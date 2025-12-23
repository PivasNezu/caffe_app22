import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/reg/login.dart';
import 'ui/reg/register.dart';
import 'main_page.dart'; // твоя основная страница после логина
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // сюда можно добавить другие провайдеры
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee_App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color.fromRGBO(
          255,
          238,
          186,
          1,
        ), // фон как в CoffeeShop
        fontFamily: 'Montserrat', // общий шрифт
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'), // русский язык
      ],
      home: isLoggedIn
          ?  CoffeeShopPage() // если пользователь залогинен
          :  AuthWrapper(), // если не залогинен, показываем страницу логина/регистрации
    );
  }
}

// Обёртка для логина и регистрации
class AuthWrapper extends StatefulWidget {
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showLogin = true;

  void onLoginSuccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CoffeeShopPage()),
    );
  }

  void onRegisterSuccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CoffeeShopPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginPage(
            onLoginSuccess: onLoginSuccess,
            onRegisterTap: () {
              setState(() {
                showLogin = false;
              });
            },
          )
        : RegisterPage(
            onRegisterSuccess: onRegisterSuccess,
            onLoginTap: () {
              setState(() {
                showLogin = true;
              });
            },
          );
  }
}
