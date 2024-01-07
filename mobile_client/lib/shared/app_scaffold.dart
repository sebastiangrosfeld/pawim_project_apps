import 'package:flutter/material.dart';
import 'package:mobile_client/app_state.dart';
import 'package:provider/provider.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.title, required this.body, this.floatingActionButton});

  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: widget.floatingActionButton,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const Text(
                    'Computers App',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<AppState>(builder: (context, appState, child) {
                    return TextButton(
                        onPressed: () {
                          appState.setJwt(null);
                          appState.setGoogleToken(null);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text('Logout'));
                  }),
                  Consumer<AppState>(builder: (context, appState, child) {
                    return TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/change-password');
                        },
                        child: Text('Change password'));
                  }),
                ],
              ),
            ),
            ListTile(
              title: Text('Computers'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/computers');
              },
            ),
            ListTile(
              title: Text('Rams'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/rams');
              },
            ),
            ListTile(
              title: Text('Gpus'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/gpus');
              },
            ),
            ListTile(
              title: Text('Scanner'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/scanner');
              },
            ),
          ],
        ),
      ),
      body: widget.body,
    );
  }
}
