import 'package:doc_app/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final Uri phoneNum = Uri.parse('07707777');

    final args = ModalRoute.of(context)!.settings.arguments as Doctor;

    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/${args.doctorPicture}',
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Svg('assets/svg/back.svg'),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Svg('assets/svg/Favorite.svg'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  args.doctorName,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${args.doctorSpecialty} • ${args.doctorHospital}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'review ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '${args.doctorName} • ${args.doctorDescription}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Color.fromARGB(255, 216, 216, 216),
                        letterSpacing: 0.5,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Spacer(),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Experience',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                args.doctorYearOfExperince,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.blue),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'yr',
                                style: Theme.of(context).textTheme.headline5,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const VerticalDivider(
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text(
                            'Patient',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                args.doctorNumberOfPatient,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.blue),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'ps',
                                style: Theme.of(context).textTheme.headline5,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const VerticalDivider(
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text(
                            'Ratting',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                args.doctorRating,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromARGB(255, 236, 236, 236),
                          image: const DecorationImage(
                            image: Svg('assets/svg/call.svg',
                                color: Colors.white, size: Size(24, 24)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("book_appointment");
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width - 104,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.greenAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Appointment',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Color.fromARGB(255, 52, 52, 52)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
