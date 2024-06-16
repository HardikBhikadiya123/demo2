import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class circulurProgressIndicatorWidget extends StatefulWidget {
  final String tital;
  final Color color;
  final int perValue;
  const circulurProgressIndicatorWidget({super.key, required this.tital, required this.color, required this.perValue});

  @override
  State<circulurProgressIndicatorWidget> createState() => _circulurProgressIndicatorWidgetState();
}

class _circulurProgressIndicatorWidgetState extends State<circulurProgressIndicatorWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, 0, 0, 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
            ),
            CircularPercentIndicator(
              percent: widget.perValue/100,
              radius: 30,
              lineWidth: 8,
              animation: true,
              animateFromLastPercent: true,
              progressColor: widget.color,
              backgroundColor: AppColors.white,
              center: Text(
                "${widget.perValue}%",
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12,
                  color: AppColors.Black,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          widget.tital,
          style: TextStyle(
            fontFamily: 'Readex Pro',
            color: AppColors.SecondaryText,
            fontSize: 14,
            letterSpacing: 0,
          ),textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
