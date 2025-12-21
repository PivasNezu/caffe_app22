import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onRegisterSuccess;
  final VoidCallback onLoginTap;

  const RegisterPage({
    super.key,
    required this.onRegisterSuccess,
    required this.onLoginTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? selectedGender;

  void tryRegister() {
    if (nameController.text.trim().isEmpty ||
        genderController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пожалуйста, заполните все поля")),
      );
      return;
    }
    widget.onRegisterSuccess();
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
            // Верхний блок: название + логотип
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
                  const SizedBox(height: 50),
                ],
              ),
            ),

            // Основной блок: форма поднята
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Имя
                        SizedBox(
                          width: fieldWidth,
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Имя",
                              hintStyle: const TextStyle(
                                color: Color(0xFF7B7166),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.6),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Пол (занимает всю ширину)
                        SizedBox(
                          width: fieldWidth,
                          child: DropdownButtonFormField<String>(
                            value: selectedGender,
                            hint: const Text("Пол"),
                            items: const [
                              DropdownMenuItem(
                                value: "Муж.",
                                child: Text("Муж."),
                              ),
                              DropdownMenuItem(
                                value: "Жен.",
                                child: Text("Жен."),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedGender = val;
                                genderController.text = val!;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.6),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Телефон
                        SizedBox(
                          width: fieldWidth,
                          child: IntlPhoneField(
                            controller: phoneController,
                            initialCountryCode: 'RU',
                            showCountryFlag: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            readOnly: false,
                            disableLengthCheck: false,
                            decoration: InputDecoration(
                              hintText: 'Телефон',
                              hintStyle: const TextStyle(
                                color: Color(0xFF7B7166),
                              ),
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.6),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Кнопка "Зарегистрироваться"
                        SizedBox(
                          width: fieldWidth,
                          child: ElevatedButton(
                            onPressed: tryRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              "Зарегистрироваться",
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

                        // Ссылка на вход
                        GestureDetector(
                          onTap: widget.onLoginTap,
                          child: const Text(
                            "У меня уже есть аккаунт",
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
                ),
              ),
            ),

            const SizedBox(height: 10), // нижний отступ
          ],
        ),
      ),
    );
  }
}
