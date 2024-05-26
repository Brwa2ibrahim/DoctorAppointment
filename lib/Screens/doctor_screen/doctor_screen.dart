import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doc_app/controllers/appointment_controller.dart';

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointments'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        var appointments = controller.appointments.where((appointment) => appointment['doctor_id'] == controller.currentUser?.uid).toList();

        if (appointments.isEmpty) {
          return Center(child: Text('No appointments found.'));
        }

        return ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            var appointment = appointments[index];
            return ListTile(
              title: Text(appointment['user_name']),
              subtitle: Text('${appointment['date']} - ${appointment['time']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () => controller.updateAppointmentStatus(appointment['appointment_id'], 'complete'),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => controller.updateAppointmentStatus(appointment['appointment_id'], 'cancel'),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
