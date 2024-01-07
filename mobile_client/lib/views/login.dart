import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_client/app_state.dart';
import 'package:mobile_client/constants.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/user_login.dart';
import 'package:mobile_client/services/auth_service.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _authService = locator<AuthService>();
  final _googleSignIn = GoogleSignIn(
    clientId: googleClientId,
    scopes: ['email', 'profile', 'openid'],
  );

  bool _isLoading = false;
  bool _invalidCredentials = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    setState(() {
      _invalidCredentials = false;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await _login();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final userLogin = UserLogin(username: username, password: password);
    final jwt = await _authService.login(userLogin);

    if (jwt == null) {
      setState(() {
        _invalidCredentials = true;
      });
      return;
    }

    Provider.of<AppState>(context, listen: false).setJwt(jwt);
    Navigator.pushReplacementNamed(context, '/computers');
  }

  Future<void> _loginWithGoogle() async {
    final account = await _googleSignIn.signIn();

    if (account == null) {
      return;
    }

    final auth = await account.authentication;
    final token = auth.idToken;

    Provider.of<AppState>(context, listen: false).setGoogleToken(token!);
    Navigator.pushReplacementNamed(context, '/computers');
  }

  @override
  Widget build(BuildContext context) {
    final inversePrimaryColor = Theme.of(context).colorScheme.inversePrimary;
    final errorColor = Theme.of(context).colorScheme.error;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: inversePrimaryColor,
        title: Text(localizations.login),
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
                      Text('Login', style: TextStyle(fontSize: 38.0)),
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
                          hintText: 'Enter your password',  // Podpowiedź
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
                      const SizedBox(height: 16),
                      Text(
                        _invalidCredentials ? localizations.invalidCredentials : '',
                        style: TextStyle(color: errorColor),
                      ),
                      const SizedBox(height: 16),
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
                        child: Text('Login'),
                      ),
                      const SizedBox(height: 8),
                      Text(' '),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _loginWithGoogle,
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Kolor tła przycisku
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
                        child: Text(localizations.loginWithGoogle.toUpperCase()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
