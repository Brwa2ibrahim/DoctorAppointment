import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getData = getUserdata();
  }

  var isLoading = false.obs;
  User? currentUser = FirebaseAuth.instance.currentUser;
  var username = ''.obs;
  var email = ''.obs;
  var location = ''.obs;
  var isDoctor = false.obs; // Add this

  Future? getData;

  Future<void> getUserdata() async {
    if (currentUser == null) {
      Get.snackbar('Error', 'No user logged in');
      return;
    }

    isLoading(true);

    try {
      print(currentUser);
      DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      var userData = user.data();
      if (userData != null) {
        username.value = userData['fullname'] ?? "";
        email.value = currentUser!.email ?? '';
        location.value = userData['location'] ?? "";
        isDoctor.value = false; // Check if the user is a doctor
      } else if (userData == null) {
        DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
            .instance
            .collection('doctors')
            .doc(currentUser!.uid)
            .get();
        var userData = user.data();
        username.value = userData!['docName'] ?? "";
        email.value = currentUser!.email ?? '';
        location.value = userData['docAdress'] ?? "";
        isDoctor.value = true;
      }else 
      {
        Get.snackbar('Error', 'User data not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data');
    } finally {
      isLoading(false);
    }
  }
}
