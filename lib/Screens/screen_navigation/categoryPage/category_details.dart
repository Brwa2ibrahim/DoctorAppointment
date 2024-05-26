import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/Screens/screen_navigation/homePage/doctor_profile.dart';
import 'package:doc_app/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;

  const CategoryDetailsView({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(catName),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('doctors')
              .where('docCategory', isEqualTo: catName)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data?.docs;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 170,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 16),
                  itemCount: data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      height: 100,
                      width: 150,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            color: AppColors.colMain,
                            child: Image.asset(
                              "assets/images/2.png",
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data![index]['docName']),
                          VxRating(
                            selectionColor: AppColors.golden,
                            onRatingUpdate: (value) {},
                            maxRating: 5,
                            count: 5,
                            value: double.parse(
                                data[index]['docRating'].toString()),
                            stepInt: true,
                          ),
                        ],
                      ),
                    ).onTap(() {
                      Get.to(() => DoctorProfileView(doc: data[index]));
                    });
                  },
                ),
              );
            }
          },
        ));
  }
}
