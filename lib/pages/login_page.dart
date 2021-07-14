import 'package:flutter/material.dart';
import 'package:surf_test/resources/surftest_colors.dart';
import 'package:surf_test/resources/surftest_images.dart';
import 'package:surf_test/widgets/login_widget.dart';



class LoginPage  extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SurfTestColors.backgroundColor,
      body: Stack(
        children: [
          Container(
            height: 378,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(SurfTestImages.bg),
                  fit: BoxFit.cover,
                ),
                color: SurfTestColors.backgroundColor),
          ),
          LoginWidget()
        ],
      ),
    );
  }
}
