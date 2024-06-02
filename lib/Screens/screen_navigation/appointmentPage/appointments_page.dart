import 'package:doc_app/Screens/screen_navigation/appointmentPage/appointment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doc_app/controllers/appointment_controller.dart';
import 'package:doc_app/widgets/schedule_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

enum FilterStatus { upcoming, complete, cancel }

class _ScheduleScreenState extends State<ScheduleScreen> {
  final AppointmentController _appointmentController =
      Get.put(AppointmentController());
  FilterStatus status = FilterStatus.upcoming;
  int _buttonIndex = 0;

  @override
  void initState() {
    super.initState();
    bool isDoctor = Get.arguments ?? false;
    _appointmentController.fetchAppointments(isDoctor);
  }

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('HH:mm').format(dateTime);
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

              List<Map<String, dynamic>> filteredAppointments =
                  _appointmentController.appointments.where((appointment) {
                print(appointment.toString());
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
                    status: status == FilterStatus.cancel ? 3 : status == FilterStatus.complete ? 2 :  1  ,
                    isDV: false,
                    doctorName: appointment['doctor_name'],
                    category: appointment['category'],
                    date: formatDate(appointment['date']), // Format date
                    time: formatTime(appointment['date']), // Format time
                    doctorProfile: appointment['doctor_profile'],
                    appointmentId: appointment['appointment_id'],
                    isDoctor: Get.arguments ?? false,
                    userName: appointment['user_name'] ?? 'Unknown User',
                    onCancel: () {
                      setState(() {
                        appointment['status'] = 'upcomming';
                        _appointmentController.updateAppointmentStatus(
                            appointment['appointment_id'], 'cancel');
                        status = FilterStatus.cancel;
                        _buttonIndex = 2;
                      });
                    },
                    accept: () {},
                    // onReschedule: () async {
                    //   var result = await Get.to(() => AppointmentScreen(
                    //         docId: appointment['doc_id'],
                    //       ));
                    //   if (result != null && result is Map<String, String>) {
                    //     setState(() {
                    //       appointment['date'] = Timestamp.fromDate(
                    //           DateTime.parse(result['date']!));
                    //       appointment['time'] = Timestamp.fromDate(
                    //           DateTime.parse(result['time']!));
                    //       _appointmentController.updateAppointmentStatus(
                    //           appointment['appointment_id'], 'upcoming');
                    //       status = FilterStatus.upcoming;
                    //       _buttonIndex = 0;
                    //     });
                    //   }
                    // },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(
    String title,
    int index,
    FilterStatus filterStatus,
  ) {
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
            color:
                _buttonIndex == index ? Colors.greenAccent : Colors.transparent,
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
