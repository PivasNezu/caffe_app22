import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeConfirmPage extends StatefulWidget {
  final VoidCallback onConfirmSuccess;
  final VoidCallback onBack;

  const CodeConfirmPage({
    super.key,
    required this.onConfirmSuccess,
    required this.onBack,
  });

  @override
  State<CodeConfirmPage> createState() => _CodeConfirmPageState();
}

class _CodeConfirmPageState extends State<CodeConfirmPage> {
  final TextEditingController codeController = TextEditingController();

  void tryConfirm() {
    if (codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Введите код подтверждения")),
      );
      return;
    }

    // тут позже можно добавить реальную проверку кода
    widget.onConfirmSuccess();
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: const [
                  Text(
                    "Введите",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "код подтверждения",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),

            const SizedBox(height: 110),

            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: fieldWidth,
                    child: TextField(
                      controller: codeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Код',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: fieldWidth,
                    child: ElevatedButton(
                      onPressed: tryConfirm,
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
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: widget.onBack,
                    child: const Text(
                      "Назад",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7B7166),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
