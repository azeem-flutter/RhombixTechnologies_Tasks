import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  String selectedEventType = 'Workshop';
  bool isImportant = false;

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Color(0xFF5E6CFF)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Color(0xFF5E6CFF)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        key: _formKey,
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
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter event title',

                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event title';
                }
                return null;
              },
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Date
            Text('Date *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                hintText: 'dd/mm/yyyy',

                prefixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select date';
                }
                return null;
              },
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Time
            Text('Time *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: _timeController,
              readOnly: true,
              onTap: () => _selectTime(context),
              decoration: InputDecoration(
                hintText: '--:--',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: Icon(Icons.access_time, color: Colors.grey[400]),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select time';
                }
                return null;
              },
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Location
            Text('Location *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Enter location',

                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter location';
                }
                return null;
              },
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Event Type
            Text('Event Type *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.spaceBtwitems),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(CSizes.sm),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedEventType,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                  ),
                  items:
                      [
                        'Workshop',
                        'Seminar',
                        'Conference',
                        'Meeting',
                        'Social',
                        'Sports',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEventType = newValue!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Priority
            Text('Priority *', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isImportant = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: CSizes.md),
                      decoration: BoxDecoration(
                        color: !isImportant ? CColors.primary : CColors.white90,
                        borderRadius: BorderRadius.circular(CSizes.sm),
                        border: Border.all(
                          color: !isImportant
                              ? CColors.primary
                              : CColors.white90,
                        ),
                      ),
                      child: Text(
                        'Normal',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: !isImportant ? CColors.white : CColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: CSizes.spaceBtwitems),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isImportant = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: CSizes.md),
                      decoration: BoxDecoration(
                        color: isImportant ? CColors.primary : CColors.white90,
                        borderRadius: BorderRadius.circular(CSizes.sm),
                        border: Border.all(
                          color: isImportant
                              ? CColors.primary
                              : CColors.white90,
                        ),
                      ),
                      child: Text(
                        'Important',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isImportant ? CColors.white : CColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: CSizes.spaceBtwitems),

            // Description
            Text('Description', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: CSizes.sm),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(hintText: 'Enter event description'),
            ),

            const SizedBox(height: CSizes.spaceBtwSections),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle form submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Event created successfully!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                }
              },

              child: Text(
                'Create Event',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: CColors.white),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwitems),
          ],
        ),
      ),
    );
  }
}
