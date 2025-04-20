import 'package:flutter/material.dart';

class Addnewpostpage extends StatefulWidget {
  const Addnewpostpage({super.key});

  @override
  State<Addnewpostpage> createState() => _AddnewpostpageState();
}

final _placeNameController = TextEditingController();
final _placeDescriptionController =TextEditingController();

@override
void dispose(){
  _placeNameController.dispose();
  _placeDescriptionController.dispose();


}
class _AddnewpostpageState extends State<Addnewpostpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children:[
            const Text("Add New Form"),
            TextField(
              controller: _placeNameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2),
                label: Text("Enter Place Name")
              ),
            ),
            const SizedBox(height: 4,),
            
             TextField(
              controller: _placeDescriptionController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2),
                label: Text("Enter Place Description")
              ),
            ),
            const SizedBox(height: 4,),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor:  Colors.blue,
                ),
                onPressed: (){},
                 child: Text("Submit")),
            )
            


            ]
        )
      ],
    );
  }
}


// Place_name		string
// Location 		string  	
// Description             string 
// Rating		double
// Governorate		string
// Place_type		string