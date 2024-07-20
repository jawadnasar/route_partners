import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/enums/message_enum.dart';
import 'package:route_partners/core/utils/chat_screen_utils/chat_screen_utils.dart';
import 'package:route_partners/model/messages_model.dart';
import 'package:route_partners/model/user_model.dart';
import 'package:route_partners/screens/widget/message_type.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? targetuser;
  final UserModel? currentUser;
  const ChatScreen({
    super.key,
    this.targetuser,
    this.currentUser,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  FlutterSoundRecorder? flutterSound;
  bool isRecorderInit = false;
  bool isRecording = false;
  void sendMessage() async {
    if (controller.text.isNotEmpty) {
      // ChatRepo().sendTextMessage(context, controller.text,
      //     widget.targetuser!.uid!, widget.currentUser!);
    }
    controller.clear();
  }

  sendFileMessage(
    File? file,
    MessageEnum messageEnum,
  ) {
    // ChatRepo().sendImageFile(
    //     context: context,
    //     receiverUid: widget.targetuser!.uid!,
    //     file: file,
    //     messageEnum: messageEnum,
    //     sendUserData: widget.currentUser);
  }

  // selectFile() async {
  //   File? file = await UserInfoController.i.pickImage(context);
  //   log(file!.path);
  //   if (FileUtils.isrequiredImageExtension(file)) {
  //     sendFileMessage(file, MessageEnum.image);
  //   } else if (FileUtils.isrequiredVideoExtension(file)) {
  //     sendFileMessage(file, MessageEnum.video);
  //   }
  // }

  @override
  void initState() {
    flutterSound = FlutterSoundRecorder();
    // openAudio();
    super.initState();
  }

  // openAudio() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw RecordingPermissionException('Mic Permission Not allowed');
  //   }
  //   await flutterSound!.openRecorder();
  //   isRecorderInit = true;
  // }

  // void sendAudio() async {
  //   var tempDir = await getTemporaryDirectory();
  //   var path = '${tempDir.path}/flutter_sound.aac';

  //   if (!ChatScreenController.i.isRecording) {
  //     log('start recorder');
  //     await flutterSound!.startRecorder(toFile: path);
  //   } else {
  //     await flutterSound!.stopRecorder();
  //     sendFileMessage(File(path), MessageEnum.audio);
  //     log('stop recorder');
  //   }
  //   ChatScreenController.i.resetisRecording();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBackgroundColor,
        bottomNavigationBar: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Flexible(
                  child: MyTextField(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Write here...',
                    controller: controller,
                    isObSecure: false,
                    // i const Icon(
                    //   FontAwesomeIcons.faceSmile,
                    //   color: Colors.grey,
                    // ),
                    // suffixIcon: GestureDetector(
                    //   child: Icon(
                    //      FontAwesomeIcons.microphone,
                    //     color: Colors.red,
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => sendMessage,
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
        ),
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
            'Ahmad',
            style: TextStyle(
              wordSpacing: 0.7,
              fontWeight: FontWeight.w500,
              color: kBlackColor,
              fontSize: 20,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: GroupedListView<Messages, DateTime>(
                    controller: scrollController,
                    elements: messages,
                    groupBy: (Messages message) => DateTime(
                      message.date!.year,
                      message.date!.month,
                      message.date!.day,
                    ),
                    groupHeaderBuilder: (Messages message) => SizedBox(
                      height: Get.height * 0.08,
                      width: double.infinity,
                      child: Align(
                        alignment: message.isSentByme == true
                            ? Alignment.bottomLeft
                            : Alignment.centerRight,
                        child: Center(
                          child: Text(
                            ChatScreenUtils.formatTime(
                              message.date.toString(),
                            ),
                            style: const TextStyle(color: kGreyColor4),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, Messages? message) {
                      return Column(
                        crossAxisAlignment: message?.isSentByme == true
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  ChatScreenUtils().borderSide(message!),
                            ),
                            color: message.isSentByme == true
                                ? kPrimaryColor
                                : Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: MessageType(
                                message: message,
                                type: message.type,
                              ),
                            ),
                          ),
                          Align(
                            alignment: message.isSentByme!
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                DateFormat('hh:mm a').format(message.date!),
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
