import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final String doctorName;
  final String category;
  final String date;
  final String time;
  final String doctorProfile;
  final String appointmentId;
  final bool isDoctor;
  final String userName;
  final Function onCancel;
  final bool isDV;
  final Function accept;
  final int status;

  const ScheduleItem({
    Key? key,
    required this.isDV,
    required this.status,
    required this.doctorName,
    required this.category,
    required this.date,
    required this.time,
    required this.doctorProfile,
    required this.appointmentId,
    required this.isDoctor,
    required this.userName,
    required this.onCancel,
    required this.accept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(doctorProfile),
          ),
          title: Text(
            doctorName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$date at $time'),
              Text(category),
            ],
          ),
          trailing: isDoctor
              ? Icon(
                  status == 3 ? Icons.cancel : Icons.check_circle,
                  color: status == 3 ? Colors.red : Colors.green,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => onCancel(),
                    ),
                    if (isDV)
                      IconButton(
                        icon: Icon(Icons.done, color: Colors.blue),
                        onPressed: () => accept(),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
