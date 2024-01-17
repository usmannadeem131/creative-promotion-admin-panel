import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ShowItemWidget extends StatelessWidget {
  const ShowItemWidget(
      {super.key, required this.title, this.isSelected = false, this.onTap});
  final String title;
  final bool isSelected;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              isSelected == false
                  ? Icons.check_box_outline_blank_outlined
                  : Icons.check_box_sharp,
              color: isSelected == false ? Colors.black : AppColor.blue,
            ),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
