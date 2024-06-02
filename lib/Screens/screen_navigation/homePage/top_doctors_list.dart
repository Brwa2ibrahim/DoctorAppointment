import 'package:doc_app/models/doctor.dart';
import 'package:flutter/material.dart';

class TopDoctorsList extends StatelessWidget {
  const TopDoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: topDoctors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/doctor_details',
                arguments: Doctor(
                  doctorName: topDoctors[index].doctorName,
                  doctorDescription: topDoctors[index].doctorDescription,
                  doctorHospital: topDoctors[index].doctorHospital,
                  doctorIsOpen: topDoctors[index].doctorIsOpen,
                  doctorNumberOfPatient:
                      topDoctors[index].doctorNumberOfPatient,
                  doctorPicture: topDoctors[index].doctorPicture,
                  doctorRating: topDoctors[index].doctorRating,
                  doctorSpecialty: topDoctors[index].doctorSpecialty,
                  doctorYearOfExperince:
                      topDoctors[index].doctorYearOfExperince,
                ),
              );
            },
            
          );
        },
      ),
    );
  }
}
