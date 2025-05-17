import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/models/postModel.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _postsCollection = 'posts';

  // Create a new post
  Future<Postmodel> createPost(Postmodel post, String userId) async {
    try {
      final docRef = await _firestore.collection(_postsCollection).add({
        'placeName': post.placeName,
        'description': post.description,
        'location': post.location,
        'governorate': post.governorate,
        'placeType': post.placeType,
        'rating': post.rating,
        'approval': post.approval,
        'userId': userId,
        'image': post.image,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return Postmodel(
        id: docRef.id,
        placeName: post.placeName,
        description: post.description,
        location: post.location,
        governorate: post.governorate,
        placeType: post.placeType,
        rating: post.rating,
        approval: post.approval,
        userId: userId,
        image: post.image,
      );
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // Update an existing post
  Future<void> updatePost(Postmodel post) async {
    try {
      await _firestore.collection(_postsCollection).doc(post.id).update({
        'placeName': post.placeName,
        'description': post.description,
        'location': post.location,
        'governorate': post.governorate,
        'placeType': post.placeType,
        'rating': post.rating,
        'approval': post.approval,
        'image': post.image,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  // Get all posts
  Stream<List<Postmodel>> getPosts() {
    return _firestore
        .collection(_postsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Postmodel(
          id: doc.id,
          placeName: data['placeName'],
          description: data['description'],
          location: data['location'],
          governorate: data['governorate'],
          placeType: data['placeType'],
          rating: data['rating'],
          approval: data['approval'],
          userId: data['userId'],
          image: data['image'],
        );
      }).toList();
    });
  }

  // Get posts by user
  Stream<List<Postmodel>> getUserPosts(String userId) {
    return _firestore
        .collection(_postsCollection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final posts = snapshot.docs.map((doc) {
        final data = doc.data();
        return Postmodel(
          id: doc.id,
          placeName: data['placeName'],
          description: data['description'],
          location: data['location'],
          governorate: data['governorate'],
          placeType: data['placeType'],
          rating: data['rating'],
          approval: data['approval'],
          userId: data['userId'],
          image: data['image'],
        );
      }).toList();
      
      // Sort posts by createdAt in memory
      posts.sort((a, b) {
        final aData = snapshot.docs.firstWhere((doc) => doc.id == a.id).data();
        final bData = snapshot.docs.firstWhere((doc) => doc.id == b.id).data();
        final aTime = aData['createdAt'] as Timestamp?;
        final bTime = bData['createdAt'] as Timestamp?;
        if (aTime == null || bTime == null) return 0;
        return bTime.compareTo(aTime); // descending order
      });
      
      return posts;
    });
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection(_postsCollection).doc(postId).delete();
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
} 