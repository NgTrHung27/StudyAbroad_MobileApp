import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: const Center(
          child: Text('This is the home page'),
        ),
      ))
    );
  }
}