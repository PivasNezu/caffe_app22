import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'providers/cart_provider.dart';
import 'providers/location_provider.dart';

import 'ui/reg/login.dart';
import 'ui/reg/register.dart';

import 'main_page.dart'; // CoffeeShopPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee_App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 238, 186, 1),
        fontFamily: 'Montserrat',
      ),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('ru', 'RU'),
      ],

      // ✅ ГЛАВНОЕ МЕСТО
      home: isLoggedIn
          ? const CoffeeShopPage()
          : const AuthWrapper(),
    );
  }
}

/// ─────────────────────────────
/// Обёртка логина / регистрации
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showLogin = true;

  Future<void> _onAuthSuccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const CoffeeShopPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginPage(
            onLoginSuccess: _onAuthSuccess,
            onRegisterTap: () {
              setState(() => showLogin = false);
            },
          )
        : RegisterPage(
            onRegisterSuccess: _onAuthSuccess,
            onLoginTap: () {
              setState(() => showLogin = true);
            },
          );
  }
}

