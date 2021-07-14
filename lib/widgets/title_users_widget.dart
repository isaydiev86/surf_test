import 'package:flutter/material.dart';

class TitleUsersWidget extends StatelessWidget {
  const TitleUsersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Пользователи",
            style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}