import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget{
  const GameScreen ({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
  }

  class _GameScreenState extends State<GameScreen>{
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Jeu du Pendu'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Text('Ici on va jouer!'),
        ),
      );
    }
  }