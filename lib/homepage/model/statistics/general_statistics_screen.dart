import 'package:flutter/material.dart';

class GeneralStatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genel İstatistik Ekranı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomPaint(
                painter: StatisticPainter(
                  title: 'Yem İstatistikleri',
                  data: [25, 50, 75, 100], // Yem istatistik verileri
                  colors: [Colors.red, Colors.green, Colors.blue, Colors.orange], // Renkler
                ),
              ),
            ),
            Expanded(
              child: CustomPaint(
                painter: StatisticPainter(
                  title: 'Padok İstatistikleri',
                  data: [10, 20, 30, 40], // Padok istatistik verileri
                  colors: [Colors.blue, Colors.yellow, Colors.green, Colors.red], // Renkler
                ),
              ),
            ),
            Expanded(
              child: CustomPaint(
                painter: StatisticPainter(
                  title: 'Tartı İstatistikleri',
                  data: [15, 30, 45, 60], // Tartı istatistik verileri
                  colors: [Colors.purple, Colors.orange, Colors.red, Colors.blue], // Renkler
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticPainter extends CustomPainter {
  final String title;
  final List<double> data;
  final List<Color> colors;

  StatisticPainter({
    required this.title,
    required this.data,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final Paint paint = Paint();
    paint.strokeWidth = 2.0;

    final double barWidth = width / data.length;
    final double maxData = data.reduce((value, element) => value > element ? value : element);

    for (int i = 0; i < data.length; i++) {
      paint.color = colors[i];
      final double barHeight = (data[i] / maxData) * height;
      final double startX = i * barWidth;
      final double startY = height - barHeight;
      final double endX = (i + 1) * barWidth;
      final double endY = height;
      canvas.drawRect(Rect.fromLTRB(startX, startY, endX, endY), paint);
    }

    TextSpan span = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      text: title,
    );
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset((width - tp.width) / 2, height - 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
