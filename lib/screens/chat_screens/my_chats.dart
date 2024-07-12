import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/utils/chat_screen_utils/chat_screen_utils.dart';
import 'package:route_partners/model/user_model.dart';
import 'package:route_partners/screens/chat_screens/chat_screen.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class MyChats extends StatefulWidget {
  const MyChats({super.key});

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: MyText(
                        text: 'Messages',
                        size: 20,
                      ),
                    ),
                    // const CircleWithIcon(
                    //   icon: Icons.more_horiz,
                    // ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                TextField(
                  controller: searchController,
                  style: TextStyle(color: Theme.of(context).iconTheme.color),
                  onChanged: ((value) {
                    setState(() {});
                  }),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: kGreyColor9,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: kTextColor4),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 15,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    hintText: 'Search Contacts',
                    hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w200,
                      color: Theme.of(context).hintColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).cardColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: ((context, index) {
                      return UsersListview(
                        username: 'My name',
                        image: Assets.boyIcon,
                        uid: '1232313213213',
                        time: DateTime.now().toString(),
                        lastMessage: 'Hello',
                      );
                    }))
              ],
            ),
          ),
        ));
  }
}

class UsersListview extends StatelessWidget {
  final String? uid;
  final String? username;
  final String? image;
  final String? time;
  final String? lastMessage;

  const UsersListview({
    super.key,
    this.username = 'Hello world',
    this.image,
    this.time,
    this.uid,
    this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () async {
          Get.to(() => const ChatScreen());
        },
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 20, top: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: CircleAvatar(
            backgroundColor: kTextColor4,
            radius: 20,
            backgroundImage: AssetImage(image!),
          ),
          title: MyText(
            text: username!,
            size: 16,
            textAlign: TextAlign.start,
          ),
          subtitle: Text(lastMessage!),
          trailing: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                    child: Text(
                  ChatScreenUtils.formatTime(time!),
                  style: const TextStyle(color: kTextColor4),
                )),
                // const Expanded(
                //     child: Icon(
                //   Icons.done_all,
                //   color: Colors.green,
                // )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
