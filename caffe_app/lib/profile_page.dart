import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // чтобы иметь доступ к CoffeeShopPage
import 'ui/order_history/order_history_page_1.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = 'Твое имя';

  void _editName() {
    final controller = TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Изменить имя'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Введите имя'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    userName = controller.text.trim();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => AuthWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 238, 186, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Карточка профиля
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 246, 218, 1),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Имя пользователя (кликабельное)
                    Center(
                      child: GestureDetector(
                        onTap: _editName,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800, // жирнее
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _InfoRow(
                      title: 'Баллы',
                      value: '100',
                      valueColor: Colors.amber[700], // золотистый
                    ),

                    const SizedBox(height: 8),

                    _InfoRow(title: 'Заказов', value: '12'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Объединённые кнопки
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 246, 218, 1),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _ProfileButton(
                      text: 'История заказов',
                      imagePath: 'assets/icons/check.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OrdersHistoryPage(),
                          ),
                        );


                      },
                    ),
                    const Divider(height: 0, color: Colors.black12),
                    _ProfileButton(
                      text: 'Выйти',
                      imagePath: 'assets/icons/exit.png',
                      onTap: _logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────
/// Виджет строки информации
class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.title, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800, // жирнее
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800, // жирнее
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────
/// Кнопки профиля
class _ProfileButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const _ProfileButton({
    required this.text,
    required this.imagePath,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // растянуть на всю ширину родителя
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        color: Colors.transparent, // важно, чтобы GestureDetector "видел" нажатия
        child: Row(
          children: [
            Image.asset(imagePath, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
