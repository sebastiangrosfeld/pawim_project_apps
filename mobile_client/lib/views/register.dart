import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/user_register.dart';
import 'package:mobile_client/services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _authService = locator<AuthService>();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await _register();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final userRegister = UserRegister(username: username, password: password);
    await _authService.register(userRegister);

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final inversePrimaryColor = Theme.of(context).colorScheme.inversePrimary;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: inversePrimaryColor,
        title: Text(localizations.register),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Column(
                children: [
                  Text(
                    'Computers App',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(localizations.login),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text(localizations.register),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? SpinKitDualRing(color: Color.fromARGB(255, 0, 0, 0))
          : Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Register', style: TextStyle(fontSize: 38.0)),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: localizations.username,
                          border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your username',  // Podpowiedź
                          hintStyle: TextStyle(color: Colors.grey),  // Styl podpowiedzi
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),  // Wewnętrzny padding
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return localizations.required;
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: localizations.password,
                          border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your username',  // Podpowiedź
                          hintStyle: TextStyle(color: Colors.grey),  // Styl podpowiedzi
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),  // Wewnętrzny padding
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return localizations.required;
                          }

                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Kolor tła przycisku
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Kolor tekstu
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)), // Styl tekstu
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)), // Padding przycisku
                        // Możesz dostosować inne właściwości ButtonStyle według potrzeb
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Dostosuj zaokrąglenie krawędzi
                            ),
                          ),
                        ),
                        child: Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
