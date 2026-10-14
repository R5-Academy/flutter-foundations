import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 50, fontWeight: .bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Loja da Academia')),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyWidget(),
                SizedBox(height: 16),
                Text('O app ja vem estilizado, mesmo sem a gente pedir.'),
                ElevatedButton(onPressed: () {}, child: Text('Clique aqui')),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Bem-vindo!',
      style: TextStyle(
        fontSize: theme.textTheme.titleLarge?.fontSize,
        fontWeight: .bold,
        color: theme.primaryColor,
      ),
    );
  }
}
