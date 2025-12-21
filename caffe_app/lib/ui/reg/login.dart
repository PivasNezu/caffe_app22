import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onRegisterTap;

  const LoginPage({
    super.key,
    required this.onLoginSuccess,
    required this.onRegisterTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  void tryLogin() {
    if (phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пожалуйста, введите номер телефона")),
      );
      return;
    }
    widget.onLoginSuccess(); // успешно вошли
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = 260;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 238, 186, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Верхний блок: логотип + название
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    "Добро",
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Пожаловать",
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 80), // отступ вместо логотипа
                ],
              ),
            ),

            const SizedBox(height: 110), // расстояние от логотипа до блока
            // Средний блок: поле + кнопка + ссылка
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Поле телефона
                  SizedBox(
                    width: fieldWidth,
                    child: IntlPhoneField(
                      controller: phoneController,
                      initialCountryCode: 'RU',
                      showCountryFlag: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      readOnly: false,
                      disableLengthCheck: false,
                      decoration: InputDecoration(
                        hintText: 'Телефон',
                        hintStyle: const TextStyle(color: Color(0xFF7B7166)),
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.6),
                        contentPadding: const EdgeInsets.fromLTRB(
                          10,
                          8,
                          10,
                          10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Кнопка "Войти"
                  SizedBox(
                    width: fieldWidth,
                    child: ElevatedButton(
                      onPressed: tryLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Войти",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Ссылка на регистрацию
                  GestureDetector(
                    onTap: widget.onRegisterTap,
                    child: const Text(
                      "Нет аккаунта? Зарегистрируйся!",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF7B7166),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(), // оставшееся пространство внизу
          ],
        ),
      ),
    );
  }
}
