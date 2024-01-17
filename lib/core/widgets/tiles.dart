// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import '../utils/functions.dart';
import '../utils/references.dart';

class CustomListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle, imgurl;
  final String role;
  final VoidCallback? accpet, reject;
  const CustomListTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imgurl,
    required this.accpet,
    required this.reject,
    this.role = "",
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: imgurl.isNotEmpty ? NetworkImage(imgurl) : null,
        child: imgurl.isEmpty ? Text(getInitialCharacters(title)) : null,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          reject != null
              ? IconButton(
                  constraints: const BoxConstraints(),
                  splashRadius: 25,
                  onPressed: reject,
                  icon: SvgPicture.asset(AppAssets.reject))
              : const Offstage(),
          accpet != null
              ? IconButton(
                  constraints: const BoxConstraints(),
                  splashRadius: 25,
                  onPressed: accpet,
                  icon: SvgPicture.asset(AppAssets.accept))
              : const Offstage(),
        ],
      ),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: title),
            TextSpan(
                text: role,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}

class TapTileWidget extends StatelessWidget {
  final String iconRef;
  final VoidCallback onTap;
  final String title;
  final Color iconColor, textColor, backgroundColor;
  const TapTileWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.iconColor,
    required this.iconRef,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * .01),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(9),
            bottomLeft: Radius.circular(9),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            SvgPicture.asset(
              iconRef,
              width: 30,
              color: iconColor,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const TitleWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 12.0;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Ink(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: AppColor.blue,
              )),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class CardTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const CardTileWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
