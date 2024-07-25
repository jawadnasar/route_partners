import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final messageController = TextEditingController();

  Future<DocumentReference> getOrCreateChat(
      String userId1, String userId2) async {
    // Generate a chat ID using the two user IDs (sorted to ensure uniqueness)
    List<String> userIds = [userId1, userId2];
    userIds.sort();
    String chatId = userIds.join("_");

    // Check if the chat document already exists
    DocumentReference chatDocRef = _firestore.collection('chats').doc(chatId);
    DocumentSnapshot chatDoc = await chatDocRef.get();

    // If the chat document doesn't exist, create it
    if (!chatDoc.exists) {
      await chatDocRef.set({
        'users': userIds,
      });
    }

    return chatDocRef;
  }

  void sendMessage(String chatId, String senderId, String messageText) {
    _firestore.collection('chats').doc(chatId).collection('messages').add({
      'text': messageText,
      'sender': senderId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
