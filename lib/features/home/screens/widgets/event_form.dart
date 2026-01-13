import 'package:campuspulse/features/home/controllers/addevent_controller.dart';
import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:campuspulse/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final controller = Get.put(AddEventController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: CColors.darkerGrey60),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add New Event',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: CColors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(CSizes.lg),
          children: [
            // Event Title
            Text(
              'Event Title *',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: controller.titleController,
              validator: (value) =>
                  CValidator.validatetextfield(value, 'title'),
              decoration: const InputDecoration(
                hintText: 'Enter event title',
                prefixIcon: Icon(Icons.title),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Date
            Text('Date *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: controller.dateController,
              readOnly: true,
              validator: (value) => CValidator.validatetextfield(value, 'Date'),
              onTap: () => controller.selectDate(context),
              decoration: const InputDecoration(
                hintText: 'dd/mm/yyyy',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Time
            Text('Time *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: controller.timeController,
              readOnly: true,
              validator: (value) => CValidator.validatetextfield(value, 'Time'),
              onTap: () => controller.selectTime(context),
              decoration: const InputDecoration(
                hintText: '--:--',
                prefixIcon: Icon(Icons.access_time),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Location
            Text('Location *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: controller.locationController,
              validator: (value) =>
                  CValidator.validatetextfield(value, 'Location'),
              decoration: const InputDecoration(
                hintText: 'Enter location',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Event Type
            Text('Event Type *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(
                () => DropdownButtonFormField<String>(
                  initialValue: controller.selectedEventType.value,
                  dropdownColor: dark ? CColors.black : Colors.white,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: dark ? CColors.black : Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CSizes.sm),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CSizes.sm),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CSizes.sm),
                      borderSide: BorderSide(color: CColors.primary),
                    ),
                  ),

                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: dark ? Colors.white : Colors.black,
                  ),

                  iconEnabledColor: dark ? Colors.white : Colors.black,

                  items:
                      const [
                            'Workshop',
                            'Seminar',
                            'Conference',
                            'Meeting',
                            'Social',
                            'Sports',
                          ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),

                  onChanged: (v) => controller.selectedEventType.value = v!,
                ),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Priority
            Text('Priority *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.isImportant.value = false,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: CSizes.md,
                        ),
                        decoration: BoxDecoration(
                          color: controller.isImportant.value
                              ? CColors.white90
                              : CColors.primary,
                          borderRadius: BorderRadius.circular(CSizes.sm),
                          border: Border.all(
                            color: controller.isImportant.value
                                ? CColors.white90
                                : CColors.primary,
                          ),
                        ),
                        child: Text(
                          'Normal',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: controller.isImportant.value
                                    ? CColors.black
                                    : CColors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: CSizes.spaceBtwitems),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.isImportant.value = true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: CSizes.md,
                        ),
                        decoration: BoxDecoration(
                          color: controller.isImportant.value
                              ? CColors.primary
                              : CColors.white90,
                          borderRadius: BorderRadius.circular(CSizes.sm),
                          border: Border.all(
                            color: controller.isImportant.value
                                ? CColors.primary
                                : CColors.white90,
                          ),
                        ),
                        child: Text(
                          'Important',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: controller.isImportant.value
                                    ? CColors.white
                                    : CColors.black,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Description
            Text(
              'Description *',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              validator: (value) =>
                  CValidator.validatetextfield(value, 'Description'),
              controller: controller.descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Enter event description',
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwSections),

            // Submit Button
            ElevatedButton(
              onPressed: () => controller.saveEvent(),
              child: const Text('Create Event'),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),
          ],
        ),
      ),
    );
  }
}
