import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _DragCircleState();
}

class _DragCircleState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  bool dragStart = false;
  bool dragStartpointer = false;
  late AnimationController _controller;
  final List<Offset> _trailBlack = [];
  final List<Offset> _trailGreen = [];
  final List<Offset> _trailYellow = [];
  final List<Offset> _trailRed = [];

  final Color _blackColor = const Color(0xFF075e54);
  final Color _greenColor = const Color(0xFF3EB771);
  final Color _yellowColor = const Color(0xFF075e54);
  final Color _redColor = const Color(0xFF3EB771);
  final double sideLength = 50.0;
  double trailWidth = 3;
  late Offset _pointer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        if (!dragStart && !dragStartpointer) {
          _updateTrail();
          setState(() {});
        }
      });
    _controller.repeat(period: const Duration(seconds: 2));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    setState(() {
      _pointer = Offset((screenWidth - (sideLength / 2)) / 2,
          (screenHeight - (sideLength / 2)) / 2);
    });
  }

  int maxTrailLength = 15;

  void _updateTrail() {
    if (_trailBlack.length >= maxTrailLength) {
      _trailBlack.removeAt(0);
    }
    if (_trailGreen.length >= maxTrailLength) {
      _trailGreen.removeAt(0);
    }
    if (_trailYellow.length >= maxTrailLength) {
      _trailYellow.removeAt(0);
    }
    if (_trailRed.length >= maxTrailLength) {
      _trailRed.removeAt(0);
    }

    double totalLength = 4 * (sideLength);
    double currentLength = _controller.value * totalLength;

    Offset calculateOffset(double length) {
      if (length <= sideLength) {
        return _pointer + Offset(length, 0);
      } else if (length <= 2 * sideLength) {
        return _pointer + Offset(sideLength, length - sideLength);
      } else if (length <= 3 * sideLength) {
        return _pointer +
            Offset(sideLength - (length - 2 * sideLength), sideLength);
      } else {
        return _pointer + Offset(0, sideLength - (length - 3 * sideLength));
      }
    }

    _trailBlack.add(calculateOffset(currentLength));
    _trailGreen
        .add(calculateOffset((currentLength + sideLength) % totalLength));
    _trailYellow
        .add(calculateOffset((currentLength + 2 * sideLength) % totalLength));
    _trailRed
        .add(calculateOffset((currentLength + 3 * sideLength) % totalLength));
  }

  void _updatePointer(Offset offset) {
    setState(() {
      _pointer = offset;
      if (dragStart || dragStartpointer) {
        _updateTrail();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: Get.height,
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onPanEnd: (details) async {
              _trailBlack.clear();
              _trailGreen.clear();
              _trailYellow.clear();
              _trailRed.clear();
              setState(() {
                trailWidth = 3;
                maxTrailLength = 20;
                dragStartpointer = false;
              });
            },
            onPanStart: (details) {
              setState(() {
                trailWidth = 3;
                maxTrailLength = 20;
                _pointer =
                    Offset(details.localPosition.dx, details.localPosition.dy);
                dragStartpointer = true;
              });
            },
            onPanUpdate: (details) {
              _updatePointer(details.globalPosition);
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: TrailPainter(
                _trailBlack,
                _trailGreen,
                _trailYellow,
                _trailRed,
                _blackColor,
                _greenColor,
                _yellowColor,
                _redColor,
                trailWidth,
              ),
            ),
          ),
          Positioned(
            left: _pointer.dx,
            top: _pointer.dy,
            child: GestureDetector(
              onPanEnd: (details) async {
                _trailBlack.clear();
                _trailGreen.clear();
                _trailYellow.clear();
                _trailRed.clear();
                setState(() {
                  trailWidth = 3;
                  maxTrailLength = 20;
                  dragStartpointer = false;
                });
              },
              onPanStart: (details) {
                setState(() {
                  trailWidth = 3;
                  maxTrailLength = 20;
                  _pointer = Offset(
                      details.localPosition.dx, details.localPosition.dy);
                  dragStartpointer = true;
                });
              },
              onPanUpdate: (details) {
                _updatePointer(details.globalPosition);
              },
              child: dragStart || dragStartpointer
                  ? Container()
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            height: 40,
                            width: 40,
                            child: Image.asset('assests/download.jpg'),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrailPainter extends CustomPainter {
  final List<Offset> trailBlack;
  final List<Offset> trailRed;
  final List<Offset> trailGreen;
  final List<Offset> trailYellow;
  final Color redColor;
  final Color blackColor;
  final Color greenColor;
  final Color yellowColor;
  final double trailWidth;

  TrailPainter(
    this.trailBlack,
    this.trailGreen,
    this.trailYellow,
    this.trailRed,
    this.blackColor,
    this.greenColor,
    this.yellowColor,
    this.redColor,
    this.trailWidth,
  );

  @override
  void paint(Canvas canvas, Size size) {
    _paintTrail(canvas, trailBlack, blackColor);
    _paintTrail(canvas, trailGreen, greenColor);
    _paintTrail(canvas, trailYellow, yellowColor);
    _paintTrail(canvas, trailRed, redColor);
  }

  void _paintTrail(Canvas canvas, List<Offset> trail, Color color) {
    if (trail.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = trailWidth
      ..style = PaintingStyle.stroke;
    final path = Path()..moveTo(trail.first.dx, trail.first.dy);
    for (final offset in trail) {
      path.lineTo(offset.dx, offset.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
