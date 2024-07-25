import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/chat_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/main.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  final String currentUserId;

  ChatScreen({required this.chatId, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final _chatController = Get.find<ChatController>();
    ScrollController scrollController = ScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: kBlackColor,
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              FontAwesomeIcons.phone,
              size: 20,
              color: kBlackColor,
            ),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
        ],
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Chat',
          style: TextStyle(
            wordSpacing: 0.7,
            fontWeight: FontWeight.w500,
            color: kBlackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: MyText(text: 'No Messages Yet!'),
                  );
                }
                final messages = snapshot.data!.docs;
                List<Widget> messageBubbles = [];
                for (var message in messages) {
                  final messageText = message['text'];
                  final messageSender = message['sender'];

                  messageBubbles.add(
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(messageSender)
                          .get(),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          // return const Center(
                          //     child: CircularProgressIndicator());
                          return Container();
                        }
                        final userDoc = userSnapshot.data!;
                        final userName = userDoc['firstName'];
                        // final userProfileImage = userDoc['profileImage'];

                        return MessageBubble(
                          sender: userName,
                          text: messageText,
                          isMe: currentUserId == messageSender,
                          userProfileImage: dummyProfileImage,
                        );
                      },
                    ),
                  );
                }
                return ListView(
                  reverse: true,
                  children: messageBubbles,
                );
              },
            ),
          ),
          MessageInput(
            chatId: chatId,
            currentUserId: currentUserId,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final String userProfileImage;

  MessageBubble(
      {required this.sender,
      required this.text,
      required this.isMe,
      required this.userProfileImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(userProfileImage),
              ),
            ),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Material(
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                elevation: 5.0,
                color: isMe ? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black54,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isMe)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(userProfileImage),
              ),
            ),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final String chatId;
  final String currentUserId;

  MessageInput({required this.chatId, required this.currentUserId});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _chatController = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: Get.height * 0.08,
            width: Get.width * 0.7,
            child: MyTextField(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: 'Write here...',
              controller: _chatController.messageController,
              isObSecure: false,
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            if (_chatController.messageController.text.trim().isNotEmpty) {
              _chatController.sendMessage(widget.chatId, widget.currentUserId,
                  _chatController.messageController.text.trim());
            }
            _chatController.messageController.clear();
          },
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: kPrimaryColor,
            child: Center(
              child: Icon(
                FontAwesomeIcons.paperPlane,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
