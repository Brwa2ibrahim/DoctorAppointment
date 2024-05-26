import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/Screens/screen_navigation/homePage/doctor_profile.dart';
import 'package:doc_app/consts/consts.dart';
import 'package:doc_app/Screens/screen_navigation/homePage/doctor_grid_menu.dart';
import 'package:doc_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchConn = TextEditingController();
  int MycurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Title(color: AppColors.colMain, child: Text('welcome')),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Text(me!.location.toString().toUpperCase(),
                //     style: TextStyle(fontSize: 16)),
                const Icon(Icons.location_on)
              ],
            ),
          ),
        ],
      ),
      // drawer: myDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            // ignore: prefer_const_constructors
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                  style: Theme.of(context).textTheme.headline3,
                  children: <TextSpan>[
                    const TextSpan(text: ' Find '),
                    TextSpan(
                      text: ' your doctor ',
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                )),
                const SizedBox(
                  height: 12,
                ),

                Container(
                  height: 56,
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 16,
                    bottom: 5,
                    top: 6,
                  ),

                  //   ---------------- Box search -------------------------------
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.lightGrey,
                  ),
                  child: TextField(
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.black12),
                    controller: searchConn,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by Doctor',
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.search_normal)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const DoctorGraidMenu(),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Doctores',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    GestureDetector(
                      // onTap: () => Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => doctorsPage(),
                      //     ),
                      //     (route) => false),
                      child: Text(
                        'View all',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                FutureBuilder<QuerySnapshot>(
                    future: controller.getDoctorList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data = snapshot.data?.docs;
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: data?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => DoctorProfileView(
                                          doc: data[index],
                                        ));
                                  },
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.only(right: 8),
                                    height: 100,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 150,
                                          alignment: Alignment.center,
                                          color: Colors.blue,
                                          child: Image.asset(
                                            "assets/images/3.png",
                                            width: 100,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(data![index]['docName']),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(data[index]['docCategory'])
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    }),

                // SizedBox(
                //   height: 150,
                //   child: ListView.builder(
                //     physics: const BouncingScrollPhysics(),
                //     itemCount: 6,
                //     itemBuilder: (BuildContext context, int index) {
                //       return GestureDetector(
                //         onTap: () {
                //           Get.to(TopDoctorsCard());
                //         },
                //         child: Container(
                //           clipBehavior: Clip.hardEdge,
                //           decoration: BoxDecoration(
                //             color: Colors.black38,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           margin: const EdgeInsets.only(right: 8),
                //           height: 100,
                //           width: 150,
                //           child: Column(
                //             children: [
                //               Container(
                //                 width: 180,
                //                 color: Colors.black,
                //                 alignment: Alignment.center,
                //                 child: Image.asset(
                //                   "assets/images/1.jpg",
                //                   width: 100,
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //               Text("")
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
