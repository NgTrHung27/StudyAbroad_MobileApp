import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:shimmer/shimmer.dart';

class CarouselLoadingCustom extends StatelessWidget {
  const CarouselLoadingCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: AppColor.greyColor,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
                color: AppColor.greyColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: AppColor.greyColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.greyColor),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.greyColor),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.greyColor),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.greyColor),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.greyColor),
              ),
              const SizedBox(
                width: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
