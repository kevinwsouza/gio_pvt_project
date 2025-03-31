import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  bool isUserFieldFocused = false;
  bool isPasswordFieldFocused = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Center(
              child: Image.asset(
                'assets/frotalog_logo_1.png',
                width: 150,
                height: 80,
              ),
            ),
            const SizedBox(height: 40),
            // Título
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 35),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  isUserFieldFocused = hasFocus;
                });
              },
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: Icon(
                    Icons.person,
                    color: isUserFieldFocused ? Colors.blue : Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  floatingLabelStyle: const TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Campo de Senha
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  isPasswordFieldFocused = hasFocus;
                });
              },
              child: TextField(
                obscureText:
                    !isPasswordVisible, // Controla a visibilidade da senha
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: isPasswordFieldFocused ? Colors.blue : Colors.grey,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible =
                            !isPasswordVisible; // Alterna a visibilidade da senha
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isPasswordVisible
                          ? Colors.black
                          : Colors.grey, // Cor dinâmica do ícone
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  floatingLabelStyle: const TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                    // TO DO ... validação de salvamento no cache das informações
                  },
                  activeColor: isChecked ? Color(0xFF333333) : Colors.grey,
                  checkColor: Colors.white,
                  side: BorderSide(
                    color: isChecked ? Colors.black : Colors.grey,
                    width: 2.0,
                  ),
                ),
                Text(
                  'Lembrar informações',
                  style:
                      TextStyle(color: isChecked ? Colors.black : Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Acessar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Link "Recuperar minha senha"
            GestureDetector(
              onTap: () {
                // TO DO ... provavel navigator para nova view
              },
              child: const Text(
                'Recuperar minha senha',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
