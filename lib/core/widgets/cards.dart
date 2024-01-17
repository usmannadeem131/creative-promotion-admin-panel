import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/references.dart';
import 'others.dart';

class AgentsCardWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String email;
  final bool showIcon;
  final VoidCallback onTap;
  const AgentsCardWidget({
    super.key,
    required this.onTap,
    required this.showIcon,
    required this.name,
    required this.email,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showIcon
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.block, color: Colors.red)],
                    )
                  : const Offstage(),
              CircleImage(
                heading: name,
                imageUrl: imgUrl,
                size: 100,
                fontSize: 24,
              ),
              SizedBox(height: screenHeight * .015),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * .005),
              Expanded(
                child: Text(
                  email,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttachImageWidget extends StatelessWidget {
  final String imgAssetPath;
  final String? imgUrl;
  final VoidCallback onTap;
  const AttachImageWidget({
    super.key,
    required this.imgAssetPath,
    required this.onTap,
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: imgAssetPath.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width * 0.45,
                  height: Get.width * 0.45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      File(imgAssetPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : imgUrl != null && imgUrl!.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: Get.width * 0.45,
                      height: Get.width * 0.45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedImageWithLoader(
                          imgUrl: imgUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SvgPicture.asset(
                      AppAssets.scan,
                      width: Get.width * 0.45,
                    )),
    );
  }
}

class StockCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? quantity;
  final bool isSelected;
  final bool isPriceAvail;
  const StockCardWidget({
    super.key,
    required this.isSelected,
    required this.title,
    this.quantity,
    this.onTap,
    this.isPriceAvail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: isSelected ? Colors.transparent : Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? AppColor.red : null,
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
