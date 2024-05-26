import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doc_app/controllers/appointment_controller.dart';
import 'package:doc_app/widgets/schedule_item.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}
enum FilterStatus { upcoming, complete, cancel }

class _ScheduleScreenState extends State<ScheduleScreen> {
  final AppointmentController _appointmentController = Get.put(AppointmentController());
  FilterStatus status = FilterStatus.upcoming;
  int _buttonIndex = 0;

  @override
  void initState() {
    super.initState();
    bool isDoctor = Get.arguments ?? false;
    _appointmentController.fetchAppointments(isDoctor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedules'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              "Schedule",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFF4F6FA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatusButton("Upcoming", 0, FilterStatus.upcoming),
                _buildStatusButton("Completed", 1, FilterStatus.complete),
                _buildStatusButton("Canceled", 2, FilterStatus.cancel),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_appointmentController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              List<Map<String, dynamic>> filteredAppointments = _appointmentController.appointments.where((appointment) {
                if (status == FilterStatus.upcoming) {
                  return appointment['status'] == 'upcoming';
                } else if (status == FilterStatus.complete) {
                  return appointment['status'] == 'complete';
                } else if (status == FilterStatus.cancel) {
                  return appointment['status'] == 'cancel';
                }
                return false;
              }).toList();

              if (filteredAppointments.isEmpty) {
                return Center(child: Text('No appointments found.'));
              }

              return ListView.builder(
                itemCount: filteredAppointments.length,
                itemBuilder: (context, index) {
                  var appointment = filteredAppointments[index];
                  return ScheduleItem(
                    doctorName: appointment['doctor_name'],
                    category: appointment['category'],
                    date: appointment['date'],
                    time: appointment['time'],
                    doctorProfile: appointment['doctor_profile'],
                    appointmentId: appointment['appointment_id'],
                    isDoctor: Get.arguments ?? false,
                    userName: appointment['user_name'] ?? 'Unknown User',
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(String title, int index, FilterStatus filterStatus) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _buttonIndex = index;
            status = filterStatus;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _buttonIndex == index ? Colors.greenAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _buttonIndex == index ? Colors.white : Colors.black38,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
