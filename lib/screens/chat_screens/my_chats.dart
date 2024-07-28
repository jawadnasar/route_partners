import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/main.dart';
import 'package:route_partners/screens/chat_screens/chat_screen.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class MyChats extends StatelessWidget {
  final String currentUserId;

  const MyChats({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Chats',
          style: TextStyle(
            wordSpacing: 0.7,
            fontWeight: FontWeight.w500,
            color: kBlackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Chats Yet!'),
            );
          }
          final chatThreads = snapshot.data!.docs;
          List<Widget> chatThreadWidgets = [];
          for (var chatThread in chatThreads) {
            final chatId = chatThread.id;
            final participants = List<String>.from(chatThread['users']);
            final otherUserId =
                participants.firstWhere((id) => id != currentUserId);

            chatThreadWidgets.add(
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otherUserId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return Container();
                  }
                  final userDoc = userSnapshot.data!;
                  final userName = userDoc['firstName'];
                  // final userProfileImage = userDoc['profileImage'];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: GestureDetector(
                      onTap: () async {
                        Get.to(() => ChatScreen(
                              chatId: chatId,
                              currentUserId: currentUserId,
                            ));
                      },
                      child: ListTile(
                        // contentPadding:
                        //     const EdgeInsets.only(left: 20, top: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor: Colors.white,
                        leading: const CircleAvatar(
                          backgroundColor: kTextColor4,
                          radius: 20,
                          backgroundImage: NetworkImage(dummyProfileImage),
                        ),
                        title: MyText(
                          text: userName,
                          size: 16,
                          textAlign: TextAlign.start,
                        ),
                        subtitle: Text('Tap to view messages'),
                        // trailing: Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Column(
                        //     children: [
                        //       Expanded(
                        //           child: Text(
                        //         ChatScreenUtils.formatTime(time!),
                        //         style: const TextStyle(color: kTextColor4),
                        //       )),
                        // const Expanded(
                        //     child: Icon(
                        //   Icons.done_all,
                        //   color: Colors.green,
                        // )),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return ListView(
            children: chatThreadWidgets,
          );
        },
      ),
    );
  }
}
