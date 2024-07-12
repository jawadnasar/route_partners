
import 'package:route_partners/core/enums/message_enum.dart';
import 'package:route_partners/core/utils/chat_screen_utils/chat_screen_utils.dart';

class Messages {
  String? senderId;
  String? receiverId;
  String? message;
  MessageEnum? type;
  DateTime? date;
  bool? isSentByme;
  String? messageId;
  bool? isSeen;

  Messages(
      {this.message,
      this.date,
      this.isSentByme,
      this.isSeen,
      this.messageId,
      this.senderId,
      this.receiverId,
      this.type});

  Messages.fromJson(map) {
    senderId = map['senderId'] ?? '';
    receiverId = map['receiverId'] ?? '';
    date = ChatScreenUtils().toDateTime(map['date']);
    isSentByme = map['isSentByme'] ?? '';
    isSeen = map['isSeen'] ?? '';
    message = map['message'] ?? '';
    type = (map['type'] as String).toEnum();
    messageId = map['messageId'] ?? '';
  }

  toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'date': date,
      'isSentByme': isSentByme,
      'isSeen': isSeen,
      'message': message,
      'type': type!.type,
      'messageId': messageId
    };
  }
}

List<Messages> messages = [
  Messages(date: DateTime.now(),
  message: 'Hello World',
  isSentByme: false,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Hey there',
  isSentByme: true,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'What\'s goin on?',
  isSentByme: false,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Test message',
  isSentByme: false,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Send me a link',
  isSentByme: true,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Somethings wrong',
  isSentByme: false,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Lets hang out',
  isSentByme: true,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Test Message',
  isSentByme: true,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Test Message',
  isSentByme: true,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Test Message',
  isSentByme: false,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
  Messages(date: DateTime.now(),
  message: 'Test Message',
  isSentByme: true,
  isSeen: true,
  messageId: DateTime.now().microsecondsSinceEpoch.toString(),
  type: MessageEnum.text
  ),
];
