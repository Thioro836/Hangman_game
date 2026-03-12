import 'package:flutter/material.dart';

class HangmanPainter extends CustomPainter {
  final int errors;
  HangmanPainter({required this.errors});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint() 
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    //Base (toujours visible)
    canvas.drawLine(
      Offset(20, size.height - 20),
      Offset(size.width - 20, size.height - 20),
      paint,
    );
    //poteau vertical
    canvas.drawLine(Offset(60, size.height - 20), Offset(60, 20), paint);
    //poteau HORIZONTAL
    canvas.drawLine(Offset(60, 20), Offset(size.width / 2, 20), paint);
    //Corde
    canvas.drawLine(
      Offset(size.width / 2, 20),
      Offset(size.width / 2, 50),
      paint,
    );
    //Erreur 1: Tête
    if (errors >= 1) {
      canvas.drawCircle(Offset(size.width / 2, 70), 20, paint);
    }
    //Erreur 2: Corps
    if (errors >= 2) {
      canvas.drawLine(
        Offset(size.width / 2, 90),
        Offset(size.width / 2, 150),
        paint,
      );
    }
    //Erreur 3: Bras gauche
    if (errors >= 3) {
      canvas.drawLine(
        Offset(size.width / 2, 110),
        Offset(size.width / 2 - 30, 130),
        paint,
      );
    }
    //Erreur 4: Bras droit
    if (errors >= 4) {
      canvas.drawLine(
        Offset(size.width / 2, 110),
        Offset(size.width / 2 + 30, 130),
        paint,
      );
    }
    //Erreur 5: Jambe gauche
    if (errors >= 5) {
      canvas.drawLine(
        Offset(size.width / 2, 150),
        Offset(size.width / 2 - 30, 180),
        paint,
      );
    }
    //Erreur 6: Jambe droite
    if (errors >= 6) {
      canvas.drawLine(
        Offset(size.width / 2, 150),
        Offset(size.width / 2 + 30, 180),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
