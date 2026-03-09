import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hangman_game/data/word_list.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String _wordToGuess;
  Set<String> _guessedLetters = {};
  int _errors = 0;
  final int _maxErrors = 6;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    final random = Random();
    setState(() {
      _wordToGuess = wordList[random.nextInt(wordList.length)];
      _guessedLetters = {};
      _errors = 0;
    });
  }

  String _getDisplayedWord() {
    return _wordToGuess
        .split('')
        .map((letter) => _guessedLetters.contains(letter) ? letter : '_')
        .join(' ');
  }

  void _guessLetter(String letter) {
    setState(() {
      _guessedLetters.add(letter);
      if (!_wordToGuess.contains(letter)) {
        _errors++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu du Pendu'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //nombre d'erreurs
          Text(
            'Erreurs: $_errors / $_maxErrors',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          SizedBox(height: 30),
          // mot masqué
          Text(
            _getDisplayedWord(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
          ),
          SizedBox(height: 40),
          //clavier
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((letter) {
              final isGuessed = _guessedLetters.contains(letter);
              return ElevatedButton(
                onPressed: isGuessed ? null : () => _guessLetter(letter),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isGuessed ? Colors.grey : Colors.deepPurple,
                  minimumSize: Size(40, 40),
                ),
                child: Text(letter, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
