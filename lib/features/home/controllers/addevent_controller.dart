import 'package:campuspulse/features/home/models/event_model.dart';
import 'package:campuspulse/features/notification/controller/notification_controller.dart';
import 'package:campuspulse/services/authentication_repository.dart';
import 'package:campuspulse/services/event_repository.dart';
import 'package:campuspulse/utils/constants/image_string.dart';
import 'package:campuspulse/utils/loader/full_screen_loader.dart';
import 'package:campuspulse/utils/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddEventController extends GetxController {
  static AddEventController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  // Text controllers
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  // Dropdown & Priority
  var selectedEventType = 'Workshop'.obs;
  var isImportant = false.obs;

  // Date picker
  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      dateController.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  // Time picker
  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }

  // Save event to Firestore
  Future<void> saveEvent() async {
    if (!formKey.currentState!.validate()) return;

    CFullScreenLoader.openLoadingDialog(
      'Creating Event...',
      CImageString.loader,
    );

    try {
      final event = EventModel(
        id: const Uuid().v4(),
        title: titleController.text.trim(),
        date: dateController.text.trim(),
        time: timeController.text.trim(),
        location: locationController.text.trim(),
        type: selectedEventType.value,
        isImportant: isImportant.value,
        description: descriptionController.text.trim(),
        createdAt: DateTime.now(),
        userId: AuthenticationRepository.instance.authUser!.uid,
      );

      await EventRepository.instance.addEvent(event);
      // Add local notification for this user
      NotificationController.instance.addEventNotification(event);

      // stop loader FIRST
      CFullScreenLoader.stopLoading();

      // success message
      CLoader.successSnackBar(
        title: 'Success',
        message: 'Event created successfully',
      );

      // clear form
      titleController.clear();
      dateController.clear();
      timeController.clear();
      locationController.clear();
      descriptionController.clear();
      selectedEventType.value = 'Workshop';
      isImportant.value = false;
    } catch (e) {
      // ALWAYS stop loader in catch
      CFullScreenLoader.stopLoading();

      CLoader.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
