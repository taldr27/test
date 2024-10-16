import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _data = "Press the button to load data";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        setState(() {
          _data = jsonDecode(response.body)['title'];
        });
      } else {
        setState(() {
          _data = "Failed to load data";
        });
      }
    } catch (e) {
      setState(() {
        _data = "Error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _data,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Fetch'),
            ),
          ],
        ),
      ),
    );
  }
}
