import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/postModel.dart';
import '../services/post_service.dart';
import '../shared/auth_state.dart';
import 'Login.dart';

class EditPostPage extends StatefulWidget {
  final Postmodel post;
  
  const EditPostPage({super.key, required this.post});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _placeDescriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final PostService _postService = PostService();
  bool _isLoading = false;
  
  String? selectedGovernorate;
  final List<String> governorates = [
    'Muscat',
    'Dhofar',
    'Musandam',
    'Al Buraimi',
    'Ad Dakhiliyah',
    'North Al Batinah',
    'South Al Batinah',
    'North Ash Sharqiyah',
    'South Ash Sharqiyah',
    'Al Dhahirah',
    'Al Wusta'
  ];

  String? selectedPlaceType;
  final List<String> placeTypes = [
    'Beach',
    'Wadi',
    'Hot Spring',
    'Mountain',
    'Desert',
    'Castle',
    'Fort',
    'Museum',
    'Cave',
    'Park',
    'Souq'
  ];

  int rating = 5;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    // Check if user is logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = Provider.of<AuthState>(context, listen: false);
      if (!authState.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Login()),
        );
        return;
      }

      // Check if user owns this post
      if (authState.currentUser!.id != widget.post.userId) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You can only edit your own posts")),
        );
      }
    });

    _placeNameController.text = widget.post.placeName ?? '';
    _placeDescriptionController.text = widget.post.description ?? '';
    _locationController.text = widget.post.location ?? '';
    selectedGovernorate = widget.post.governorate;
    selectedPlaceType = widget.post.placeType;
    rating = widget.post.rating ?? 5;
    isChecked = widget.post.approval ?? false;
  }

  @override
  void dispose() {
    _placeNameController.dispose();
    _placeDescriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    final authState = Provider.of<AuthState>(context, listen: false);
    if (!authState.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Login()),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedPost = Postmodel(
        id: widget.post.id,
        placeName: _placeNameController.text.trim(),
        description: _placeDescriptionController.text.trim(),
        location: _locationController.text.trim(),
        governorate: selectedGovernorate,
        placeType: selectedPlaceType,
        rating: rating,
        approval: isChecked,
        userId: widget.post.userId,
      );

      await _postService.updatePost(updatedPost);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Post updated successfully!")),
        );
        Navigator.pop(context, updatedPost);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    
    if (!authState.isLoggedIn) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _placeNameController,
              decoration: InputDecoration(
                labelText: "Place Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFFFD966)),
                ),
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _placeDescriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFFFD966)),
                ),
              ),
              maxLines: 3,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: "Location (lat, long)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFFFD966)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Governorate",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: selectedGovernorate,
              items: governorates.map((String governorate) {
                return DropdownMenuItem(
                  value: governorate,
                  child: Text(governorate),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedGovernorate = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Place Type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: selectedPlaceType,
              items: placeTypes.map((String placeType) {
                return DropdownMenuItem(
                  value: placeType,
                  child: Text(placeType),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedPlaceType = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text("Rating: "),
                Expanded(
                  child: Slider(
                    value: rating.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    activeColor: const Color(0xFFFFD966),
                    label: rating.toString(),
                    onChanged: (double value) {
                      setState(() {
                        rating = value.round();
                      });
                    },
                  ),
                ),
                Text("$rating/5"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: const Color(0xFFFFD966),
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                const Text("Is Approved"),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD966),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
