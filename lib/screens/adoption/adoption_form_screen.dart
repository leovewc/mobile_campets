import 'package:flutter/material.dart';

class AdoptionFormScreen extends StatefulWidget {
  static String routeName = "/adoption_form";
  final String petName;

  const AdoptionFormScreen({super.key, required this.petName});

  @override
  State<AdoptionFormScreen> createState() => _AdoptionFormScreenState();
}

class _AdoptionFormScreenState extends State<AdoptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _arrivalTime = '';
  String _note = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm Adoption for ${widget.petName}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preferred Arrival Time',
                  hintText: 'e.g., Tomorrow morning',
                ),
                onChanged: (val) => _arrivalTime = val,
                validator: (val) =>
                    val!.isEmpty ? 'Please enter a time' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Notes / Special Requests',
                ),
                onChanged: (val) => _note = val,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Adoption Confirmed"),
                        content: Text(
                            "Thank you for adopting ${widget.petName}!\n\nThe pet will be delivered to your address soon."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // close dialog
                              Navigator.of(context).pop(); // return to notifications
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
