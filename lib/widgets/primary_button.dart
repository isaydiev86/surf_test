import 'package:flutter/material.dart';
import 'package:surf_test/resources/surftest_colors.dart';

class PrimaryBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool activeBtn;

  const PrimaryBtn({
    Key? key,
    required this.text,
    required this.onTap,
    required this.activeBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        width: 230,
        decoration: BoxDecoration(
          color: activeBtn ? SurfTestColors.primaryColor : SurfTestColors.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}