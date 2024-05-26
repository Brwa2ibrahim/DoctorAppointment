import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doc_app/consts/colors.dart';

class logoApp extends StatelessWidget {
  const logoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/svg/logo_app.svg',
        width: 150,
        height: 150,
        colorFilter: ColorFilter.mode(AppColors.colMain, BlendMode.srcIn),
      ),
    );
  }
}
