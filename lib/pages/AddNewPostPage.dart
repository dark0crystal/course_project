import 'package:flutter/material.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({super.key});

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _placeDescriptionController = TextEditingController();

  @override
  void dispose() {
    _placeNameController.dispose();
    _placeDescriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final name = _placeNameController.text.trim();
    final description = _placeDescriptionController.text.trim();

    if (name.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    // Handle submission logic here

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post submitted successfully!")),
    );

    // Clear fields
    _placeNameController.clear();
    _placeDescriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _placeNameController,
              decoration: const InputDecoration(
                labelText: "Place Name",
                prefixIcon: Icon(Icons.place),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _placeDescriptionController,
              decoration: const InputDecoration(
                labelText: "Place Description",
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _handleSubmit,
              icon: const Icon(Icons.send),
              label: const Text("Submit"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// Place_name		string
// Location 		string  	
// Description             string 
// Rating		double
// Governorate		string
// Place_type		string