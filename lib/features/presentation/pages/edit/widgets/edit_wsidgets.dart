import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {super.key, required this.onPressed, required this.active});

  final VoidCallback? onPressed;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor:
          active ? AppColors.colorWhite : AppColors.colorWhite.withOpacity(0.8),
      onPressed: onPressed,
      child: Icon(
        Icons.done,
        color: active
            ? AppColors.colorGreen
            : AppColors.colorGreen.withOpacity(0.8),
        size: 30,
      ),
    );
  }
}

class DeleteContainer extends StatelessWidget {
  const DeleteContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      color: AppColors.colorWhite,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        width: 96,
        height: 96,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SvgPicture.asset(
            'assets/icons/remove.svg',
          ),
        ),
      ),
    );
  }
}
