import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/colors.dart';

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
