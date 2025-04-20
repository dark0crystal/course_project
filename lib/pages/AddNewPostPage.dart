import 'package:flutter/material.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({super.key});

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}




class _AddNewPostPageState extends State<AddNewPostPage> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _placeDescriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  

  String? selectedGovernorate;
  final List<String> Governorates =['Muscat','Ibri'];

  String? selectedPlaceType;
  final List<String> PlaceTypes =['Beach','Wadi','Hot Spring'];

  @override
  void dispose() {
    _placeNameController.dispose();
    _placeDescriptionController.dispose();
    super.dispose();
  }

  void handleSubmit() {
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
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: "Location in eg. 23.4445 ,34.444445",
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Column( 
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Choose a Governorate:",
                    border:OutlineInputBorder(),
                  ),
                  value: selectedGovernorate,
                  items: Governorates.map((String governorate){
                      return DropdownMenuItem(
                        value: governorate,
                        child:  Text(governorate),
                      );
                  }).toList()
                  , onChanged: (newValue){
                    setState(() {
                      selectedGovernorate =newValue;
                    });
                  }
                ),
                SizedBox(height: 24),
                Text(
                  selectedGovernorate ==null ? "no governorate selected" :"selected $selectedGovernorate",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(height:24),
            
            Column( 
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Choose a Place Type:",
                    border:OutlineInputBorder(),
                  ),
                  value: selectedPlaceType,
                  items: PlaceTypes.map((String placeType){
                      return DropdownMenuItem(
                        value: placeType,
                        child:  Text(placeType),
                      );
                  }).toList()
                  , onChanged: (newValue){
                    setState(() {
                      selectedPlaceType =newValue;
                    });
                  }
                ),
                SizedBox(height: 24),
                Text(
                  selectedGovernorate ==null ? "no place type selected" :"selected $selectedPlaceType",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: handleSubmit,
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