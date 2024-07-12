import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/enums/message_enum.dart';
import 'package:route_partners/core/utils/chat_screen_utils/chat_screen_utils.dart';
import 'package:route_partners/model/messages_model.dart';

class MessageType extends StatelessWidget {
  final Messages? message;
  final MessageEnum? type;
  const MessageType({super.key, this.message, this.type});

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    if (type == MessageEnum.image) {
      return GestureDetector(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: message!.message!,
              width: Get.width * 0.5,
              fit: BoxFit.fill,
              key: UniqueKey(),
            ),
          ],
        ),
      );
    } else if (message!.type == MessageEnum.text) {
      return Text(
        message!.message!,
        style: TextStyle(
            color: message!.isSentByme!
                ? Colors.white
                : Colors.black),
      );
    }
    // else if (message!.type == MessageEnum.video) {
    //   log('i am over here');
    //   return VideoPlayerWidget(
    //     videoUrl: message!.message!,
    //   );
    // }

    else {
      return StatefulBuilder(
        builder: (context, setState) {
          return IconButton(
            constraints: const BoxConstraints(maxWidth: 100),
            icon: isPlaying
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
            onPressed: (() async {
              if (isPlaying == false) {
                // await audioPlayer.play(UrlSource(message!.message!));
                setState(
                  () {
                    isPlaying = true;
                    log(isPlaying.toString());
                  },
                );
              } else {
                // audioPlayer.pause();
                setState(
                  () {
                    isPlaying = false;
                    log(isPlaying.toString());
                  },
                );
              }
            }),
          );
        },
      );
    }
  }
}
