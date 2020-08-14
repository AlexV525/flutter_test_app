///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/7/11 12:16
///

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:testapp/constants/constants.dart';

@FFRoute(name: "/test-progress-bar", routeName: "Custom progress bar")
class ProgressBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CircleProgressBar')),
      body: Center(
        child: CircleProgressBar(
          duration: 5.seconds,
          outerRadius: 120.0,
          ringsColor: Color(0xff00bc56),
          ringsWidth: 20.0,
        ),
      ),
    );
  }
}

class CircleProgressBar extends StatefulWidget {
  const CircleProgressBar({
    Key key,
    @required this.duration,
    @required this.outerRadius,
    @required this.ringsWidth,
    @required this.ringsColor,
    this.progress = 0.0,
  }) : super(key: key);

  final Duration duration;
  final double outerRadius;
  final double progress;
  final double ringsWidth;
  final Color ringsColor;

  @override
  State<StatefulWidget> createState() => _CircleProgressState();
}

class _CircleProgressState extends State<CircleProgressBar> with SingleTickerProviderStateMixin {
  final GlobalKey paintKey = GlobalKey();

  AnimationController progressController;
  Animation<double> progressAnimation;
  CurvedAnimation progressCurvedAnimation;

  @override
  void initState() {
    super.initState();

    progressController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    progressController.value = widget.progress ?? 0.0;

    progressCurvedAnimation = CurvedAnimation(
      parent: progressController,
      curve: Curves.linear,
    );

    progressAnimation = Tween(
      begin: widget.progress ?? 0.0,
      end: 1.0,
    ).animate(progressCurvedAnimation);

    progressController.addListener(() {
      setState(() {});
    });

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      progressController.forward();
    });
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.outerRadius * 2;
    final Size size = Size(width, width);
    return Center(
      child: CustomPaint(
        key: paintKey,
        size: size,
        painter: ProgressPainter(
          dotRadius: widget.ringsWidth,
          dotColor: widget.ringsColor,
          progress: progressController.value,
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({
    this.dotRadius,
    this.dotColor,
    this.progress,
  });

  final double dotRadius;
  final Color dotColor;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final double center = size.width / 2;
    final Offset offsetCenter = Offset(center, center);
    final double drawRadius = size.width / 2 - dotRadius;
    final angle = 360.0 * progress;
    final double radians = angle.toRad;

    final double outerRadius = center;
    final double innerRadius = center - dotRadius * 2;

    // draw progress.
    if (progress > 0.0) {
      final progressWidth = outerRadius - innerRadius;
      final double offset = 0;
      if (radians > offset) {
        canvas.save();
        canvas.translate(0.0, size.width);
        canvas.rotate(-90.0.toRad);
        final Rect arcRect = Rect.fromCircle(center: offsetCenter, radius: drawRadius);
        final progressPaint = Paint()
          ..color = dotColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth;
        canvas.drawArc(arcRect, 0, radians - offset, false, progressPaint);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter _) => true;
}

extension _MathExtension on num {
  num get toRad => this * (math.pi / 180.0);

  num get toDeg => this * (180.0 / math.pi);
}
