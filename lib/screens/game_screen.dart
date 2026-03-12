import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hangman_game/data/word_list.dart';
import 'package:hangman_game/models/word.dart';
import 'package:hangman_game/widgets/hangman_painter.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Word _currentWord;
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
      _currentWord = wordList[random.nextInt(wordList.length)];
      _guessedLetters = {};
      _errors = 0;
    });
  }

  String _getDisplayedWord() {
    return _currentWord.word
        .split('')
        .map((letter) => _guessedLetters.contains(letter) ? letter : '_')
        .join(' ');
  }

  void _guessLetter(String letter) {
    setState(() {
      _guessedLetters.add(letter);
      if (!_currentWord.word.contains(letter)) {
        _errors++;
      }
    });
    if (_hasWon()) {
      _showEndDialog(
        '🎉 Bravo !',
        'Vous avez trouvé le mot : ${_currentWord.word}',
      );
    } else if (_hasLost()) {
      _showEndDialog('😢 Perdu !', 'Le mot était : ${_currentWord.word}');
    }
  }

  bool _hasWon() {
    return _currentWord.word
        .split('')
        .every((letter) => _guessedLetters.contains(letter));
  }

  bool _hasLost() {
    return _errors >= _maxErrors;
  }

  void _showEndDialog(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startNewGame();
            },
            child: Text('Rejouer'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Quitter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isGameOver = _hasWon() || _hasLost();
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu du Pendu'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //indice
              Text(
                'Catégorie: ${_currentWord.category}',
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 10),
          // dessin du pendu
          CustomPaint(
            painter: HangmanPainter(errors: _errors),
            size: Size(200, 200),
          ),
          SizedBox(height: 10),
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
              Color buttonColor;
              if(!isGuessed) {
                buttonColor = Colors.deepPurple;
              } else if(_currentWord.word.contains(letter)) {
                buttonColor = Colors.green;
              }
              else {
                buttonColor = Colors.red.shade400;
              }
              return ElevatedButton(
                onPressed: (isGuessed || isGameOver)
                    ? null
                    : () => _guessLetter(letter),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  minimumSize: Size(40, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(letter, 
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
     ),
     ),
     );
  }
}
