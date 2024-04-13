import 'package:flutter/material.dart';
import 'adminHomeScreen.dart'; // Импорт страницы администратора

void main() {
  runApp(const MaterialApp(
    home: adminAuthorizationScreen(),
  ));
}

class adminAuthorizationScreen extends StatelessWidget {
  const adminAuthorizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void _login() {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      // Проверка имени пользователя и пароля
      if (username == 'admin' && password == 'admin') {
        // Переход на страницу администратора
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHomeScreen()),
        );
      } else {
        // Вывод сообщения об ошибке аутентификации
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ошибка'),
              content: Text('Неправильное имя пользователя или пароль.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ОК'),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFF1F1D2B),
      appBar: AppBar(
        title: const Text('Авторизация', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Вы попали на экран администратора.\n\nЭтот раздел предназначен исключительно для администраторов системы. Если вы не являетесь администратором, пожалуйста, покиньте эту страницу.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Имя пользователя:',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Введите ваше имя',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF252836),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Пароль:',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Введите ваш пароль',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF252836),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1AACBC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  minimumSize: Size(double.infinity, 62),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Войти в систему',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
