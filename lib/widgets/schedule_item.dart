import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doc_app/controllers/appointment_controller.dart';

class ScheduleItem extends StatelessWidget {
  final String doctorName;
  final String category;
  final Timestamp date;
  final String time;
  final String doctorProfile;
  final String appointmentId;
  final bool isDoctor;
  final String userName;

  ScheduleItem({
    required this.doctorName,
    required this.category,
    required this.date,
    required this.time,
    required this.doctorProfile,
    required this.appointmentId,
    required this.isDoctor,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(doctorProfile),
        ),
        title: Text(isDoctor ? userName : doctorName), // Show userName if doctor, otherwise doctorName
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category),
            Text(date.toDate().toString()), // Convert Timestamp to DateTime and format it as needed
            Text(time),
          ],
        ),
        trailing: isDoctor
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () => updateAppointmentStatus(context, 'complete'),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => updateAppointmentStatus(context, 'cancel'),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  void updateAppointmentStatus(BuildContext context, String status) {
    // Update the appointment status in Firestore
    final appointmentController = Get.find<AppointmentController>();
    appointmentController.updateAppointmentStatus(appointmentId, status);
  }
}
