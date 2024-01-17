import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../models/store_model.dart';
import '../../../core/utils/functions.dart';
import '../../../core/widgets/others.dart';

class StoreDetailScreen extends StatelessWidget {
  final StoreModel store;
  const StoreDetailScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .07),
              Align(
                alignment: Alignment.center,
                child: Text(
                  store.storeName,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .1),
              Row(
                children: [
                  const Text(
                    "Store Information",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => singleStoreDownload(store),
                    icon: const Icon(Icons.download, size: 50),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .01),

              // Store Details
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                      offset: Offset(
                        3.0, // Move to right 5  horizontally
                        3.0, // Move to bottom 5 Vertically
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Details & Designation & Additional Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Details
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Details",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                HeadingWidget(
                                    title: "Name", textValue: store.storeName),
                                HeadingWidget(
                                    title: "Address",
                                    textValue: store.storeAddress),
                                HeadingWidget(
                                    title: "Phone",
                                    textValue: store.storePhone),
                                HeadingWidget(
                                    title: "Email",
                                    textValue: store.storeEmail),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * .02),

                          // Designation
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Designation",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                HeadingWidget(
                                    title: "Position",
                                    textValue: store.designation.designation),
                                HeadingWidget(
                                    title: "Name",
                                    textValue: store.designation.name),
                                HeadingWidget(
                                    title: "Email",
                                    textValue: store.designation.email),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * .02),

                          // Additional Info
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Additional Info:",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0, // soften the shadow
                                        spreadRadius: 3.0, //extend the shadow
                                        offset: Offset(
                                          3.0, // Move to right 5  horizontally
                                          3.0, // Move to bottom 5 Vertically
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      store.additionalInfo.isNotEmpty
                                          ? store.additionalInfo
                                          : "Empty",
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Stocks
                      const Text(
                        "Stock",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Full Synthethic
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingWidget(
                                    title: "Full Synthethic - OW-20",
                                    textValue: store.fullySyntyheticOW20),
                                HeadingWidget(
                                    title: "Full Synthethic - 5W-20",
                                    textValue: store.fullySyntyhetic5W20),
                                HeadingWidget(
                                    title: "Full Synthethic - 5W-30",
                                    textValue: store.fullySyntyhetic5W30),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * .02),

                          // High Mileage
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingWidget(
                                    title: "High Mileage - OW-20",
                                    textValue: store.highMileageOW20),
                                HeadingWidget(
                                    title: "High Mileage - 5W-20",
                                    textValue: store.highMileage5W20),
                                HeadingWidget(
                                    title: "High Mileage - 5W-30",
                                    textValue: store.highMileage5W30),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * .02),

                          // Advance
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingWidget(
                                    title: "Advance - OW-20",
                                    textValue: store.advanceOW20),
                                HeadingWidget(
                                    title: "Advance - 5W-20",
                                    textValue: store.advance5W20),
                                HeadingWidget(
                                    title: "Advance - 5W-30",
                                    textValue: store.advance5W30),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .05),

              // Store Images
              const Text(
                "Store Images",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .02),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                      offset: Offset(
                        3.0, // Move to right 5  horizontally
                        3.0, // Move to bottom 5 Vertically
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImagePreviewWidget(
                            imgUrl: store.images[0].imgUrl,
                          ),
                          const SizedBox(width: 10),
                          ImagePreviewWidget(
                            imgUrl: store.images[1].imgUrl,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .05),

              // Oil Placements Images
              const Text(
                "Oil Placement Images",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .02),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                      offset: Offset(
                        3.0, // Move to right 5  horizontally
                        3.0, // Move to bottom 5 Vertically
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImagePreviewWidget(imgUrl: store.images[2].imgUrl),
                          const SizedBox(width: 10),
                          ImagePreviewWidget(imgUrl: store.images[3].imgUrl),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * .05),
              Row(
                children: [
                  Visibility(
                    visible: store.images[4].imgUrl.isNotEmpty,
                    child: Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Cold Vault Image",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * .01),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0, // soften the shadow
                                  spreadRadius: 3.0, //extend the shadow
                                  offset: Offset(
                                    3.0, // Move to right 5  horizontally
                                    3.0, // Move to bottom 5 Vertically
                                  ),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: AspectRatio(
                                          aspectRatio: 4 / 2,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedImageWithLoader(
                                              imgUrl: store.images[4].imgUrl,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Signature",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 3.0, //extend the shadow
                                offset: Offset(
                                  3.0, // Move to right 5  horizontally
                                  3.0, // Move to bottom 5 Vertically
                                ),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AspectRatio(
                                        aspectRatio: 4 / 2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedImageWithLoader(
                                            imgUrl: store.signature.imgUrl,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * .05),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
    required this.title,
    required this.textValue,
  });
  final String title;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        width: Get.width * .3,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 3.0, //extend the shadow
              offset: Offset(
                3.0, // Move to right 5  horizontally
                3.0, // Move to bottom 5 Vertically
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              "$title: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                textValue,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePreviewWidget extends StatelessWidget {
  final String imgUrl;
  const ImagePreviewWidget({
    super.key,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 4 / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedImageWithLoader(
            fit: BoxFit.cover,
            imgUrl: imgUrl,
          ),
        ),
      ),
    );
  }
}
