import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var selectedDate = Rxn<DateTime>();
  var selectedTime = Rxn<String>();
  var appointments = <Map<String, dynamic>>[].obs;
  var currentUser = FirebaseAuth.instance.currentUser;

  var isDoctor = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkUserRole();
  }

  void checkUserRole() async {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    isDoctor.value = userDoc.data()?['isDoctor'] ?? false;
    fetchAppointments(isDoctor.value);
  }

  Future<void> fetchAppointments(bool isDoctor) async {
    isLoading(true);
    try {
      QuerySnapshot snapshot;
      if (isDoctor) {
        print(
            '---------------------- this is form the fetching function ---------------');
        print('user is docotor');
        print(currentUser?.uid);
        snapshot = await FirebaseFirestore.instance
            .collection('appointments')
            .where('doctor_id', isEqualTo: currentUser?.uid)
            .get();
      } else {
        print(
            '---------------------- this is form the fetching function ---------------');
        print('user is NOT docotor ');
        snapshot = await FirebaseFirestore.instance
            .collection('appointments')
            .where('user_id', isEqualTo: currentUser?.uid)
            .get();
      }
      Future<QuerySnapshot<Map<String, dynamic>>> getAppointment(
          bool isDoctor) {
        if (isDoctor) {
          return FirebaseFirestore.instance
              .collection('appointments')
              .where('appBy', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .get();
        } else {
          return FirebaseFirestore.instance
              .collection('appointments')
              .where('appBy', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .get();
        }
      }

      var data = snapshot.docs.map((doc) {
        var docData = doc.data() as Map<String, dynamic>;
        return {
          'doctor_name': docData['doctor_name'],
          'category': docData['category'],
          'date': docData['date'],
          'time': docData['time'],
          'doctor_profile': docData['doctor_profile'],
          'status': docData['status'],
          'appointment_id': doc.id,
          'user_name': docData['user_name'] ?? 'Unknown User',
        };
      }).toList();
      appointments.assignAll(data);
    } catch (e) {
      print('Error fetching appointments: $e');
      Get.snackbar('Error', 'Failed to fetch appointments');
    } finally {
      isLoading(false);
    }
  }

  Future<void> bookAppointment(String docId) async {
    if (selectedDate.value == null || selectedTime.value == null) {
      Get.snackbar('Error', 'Please select a date and time');
      return;
    }

    //
    final doc =
        await FirebaseFirestore.instance.collection('doctors').doc(docId).get();

    final user = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();

    print(doc.data().toString());
    print(user.data().toString());

    isLoading(true);

    try {
      var store = FirebaseFirestore.instance.collection('appointments').doc();
      await store.set({
        'date': selectedDate.value,
        'time': selectedTime.value,
        'doctor_id': docId,
        'user_id': currentUser!.uid,
        'doctor_name': doc['docName'], // Replace with actual doctor name
        'doctor_profile':
            'assets/images/2.png', // Replace with actual doctor profile image
        'category': doc['docCategory'], // Replace with actual category
        'status': "upcoming",
        'user_name': user['fullname'], // Replace with actual user name
      });

      Get.back();
      Get.back();
      Get.snackbar('Success', 'Appointment booked successfully');

      fetchAppointments(isDoctor.value); // Fetch updated appointments
    } catch (e) {
      Get.snackbar('Error', 'Failed to book appointment');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    try {
      print(appointmentId);
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({'status': status});
      fetchAppointments(isDoctor.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update appointment status');
    }
  }
}
