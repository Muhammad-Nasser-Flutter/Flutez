import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

import '../theming/colors.dart';


class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.pop();
      },
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        color: AppColors.bigTextColor,
      ),
    );
  }
}
