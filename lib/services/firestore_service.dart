import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // ============ STUDY PLANS ============

  // Save study plan
  Future<void> saveStudyPlan({
    required String title,
    required String subject,
    required String availableTime,
    required String focusType,
    required String generatedPlan,
  }) async {
    if (_userId == null) return;

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('studyPlans')
        .add({
      'title': title,
      'subject': subject,
      'availableTime': availableTime,
      'focusType': focusType,
      'generatedPlan': generatedPlan,
      'createdAt': FieldValue.serverTimestamp(),
      'isCompleted': false,
    });
  }

  // Get user's study plans
  Stream<QuerySnapshot> getStudyPlans() {
    if (_userId == null) {
      return const Stream.empty();
    }
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('studyPlans')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Delete study plan
  Future<void> deleteStudyPlan(String planId) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('studyPlans')
        .doc(planId)
        .delete();
  }

  // ============ CHAT HISTORY ============

  // Save chat message
  Future<void> saveChatMessage({
    required String message,
    required String response,
  }) async {
    if (_userId == null) return;

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('chatHistory')
        .add({
      'message': message,
      'response': response,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get chat history
  Stream<QuerySnapshot> getChatHistory() {
    if (_userId == null) {
      return const Stream.empty();
    }
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('chatHistory')
        .orderBy('timestamp', descending: false)
        .limitToLast(50)
        .snapshots();
  }

  // Clear chat history
  Future<void> clearChatHistory() async {
    if (_userId == null) return;

    final batch = _firestore.batch();
    final chats = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('chatHistory')
        .get();

    for (var doc in chats.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // ============ REMINDERS ============

  // Add reminder
  Future<void> addReminder({
    required String title,
    required String description,
    required DateTime dueDate,
  }) async {
    if (_userId == null) return;

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('reminders')
        .add({
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get reminders
  Stream<QuerySnapshot> getReminders() {
    if (_userId == null) {
      return const Stream.empty();
    }
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('reminders')
        .orderBy('dueDate')
        .snapshots();
  }

  // Toggle reminder completion
  Future<void> toggleReminder(String reminderId, bool isCompleted) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('reminders')
        .doc(reminderId)
        .update({'isCompleted': isCompleted});
  }

  // Delete reminder
  Future<void> deleteReminder(String reminderId) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('reminders')
        .doc(reminderId)
        .delete();
  }

  // ============ USER PROFILE ============

  // Create or initialize user profile
  Future<void> createUserProfile({
    required String email,
    required String name,
    String? phoneNumber,
    String? college,
    String? year,
    String? course,
    String? photoUrl,
  }) async {
    if (_userId == null) return;

    final userData = {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber ?? '',
      'college': college ?? '',
      'year': year ?? '',
      'course': course ?? '',
      'photoUrl': photoUrl ?? '',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    // Use set with merge to avoid overwriting existing data
    await _firestore.collection('users').doc(_userId).set(
      userData,
      SetOptions(merge: true),
    );
  }

  // Get user profile
  Future<DocumentSnapshot?> getUserProfile() async {
    if (_userId == null) return null;
    return await _firestore.collection('users').doc(_userId).get();
  }

  // Update user profile
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    if (_userId == null) return;
    await _firestore.collection('users').doc(_userId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}


