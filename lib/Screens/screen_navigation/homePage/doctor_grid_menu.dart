import 'package:doc_app/Screens/screen_navigation/categoryPage/category_details.dart';
import 'package:doc_app/consts/colors.dart';
import 'package:doc_app/consts/lists.dart';
import 'package:flutter/material.dart';
import 'package:doc_app/models/doctor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DoctorGraidMenu extends StatelessWidget {
  const DoctorGraidMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 8),
      padding: EdgeInsets.zero,
      itemCount: doctorMenu.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(CategoryDetailsView(catName: iconsTitleList[index]));
          },
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 81,
            ),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 36,
                    minWidth: 36,
                    maxHeight: 52,
                    maxWidth: 52,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    // Add color, gradient, or image for background if needed
                  ),
                  child: Center(
                    // Center the SVG inside the container
                    child: SvgPicture.asset(
                      iconsList[index], // Path to your SVG asset
                      color: AppColors.golden,
                      width: 40, // Desired width for your SVG
                      height: 40, // Desired height for your SVG
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Text(
                    iconsTitleList[index],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
