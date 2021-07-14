import 'package:flutter/material.dart';
import 'package:surf_test/resources/surftest_images.dart';
import 'package:surf_test/widgets/primary_button.dart';

class UsersErrorWidget extends StatelessWidget {
  final VoidCallback onTap;
  const UsersErrorWidget({
    Key? key, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(SurfTestImages.warning, width: 76, height: 66),
          const SizedBox(height: 37),
          Text(
            "Не удалось загрузить информацию",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 32),
          PrimaryBtn(
            text: "Обновить",
            onTap: onTap,
            activeBtn: true,
          )
        ],
      ),
    );
  }
}