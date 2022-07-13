import 'package:beamer/src/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/data/chatroom_model.dart';
import 'package:untitled1/repo/chat_service.dart';

class ChatListPage extends StatelessWidget {
  final String userKey;
  const ChatListPage({Key? key, required this.userKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatroomModel>>(
        future: ChatService().getMyChatList(userKey),
        builder: (context, snapshot) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) {
                  ChatroomModel chatroomModel = snapshot.data![index];
                  // 셀런지 바이언지 구별
                  bool iamBuyer = chatroomModel.buyerKey == userKey;

                  return ListTile(
                    onTap: () {
                      context.beamToNamed('/${chatroomModel.chatroomKey}');
                    },
                    // seller 이미지
                    leading: ExtendedImage.network(
                      'https://randomuser.me/api/portraits/women/11.jpg',
                      shape: BoxShape.circle,
                      fit: BoxFit.cover,
                      height: size.width / 8,
                      width: size.width / 8,
                    ),
                    // item 이미지
                    trailing: ExtendedImage.network(
                      chatroomModel.itemImage,
                      shape: BoxShape.rectangle,
                      fit: BoxFit.cover,
                      height: size.width / 8,
                      width: size.width / 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    title: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        // 채팅창 이름구별
                          text: iamBuyer
                              ? chatroomModel.sellerKey
                              : chatroomModel.buyerKey,
                          style: Theme.of(context).textTheme.subtitle1,
                          children: [
                            TextSpan(text: " "),
                            TextSpan(
                              text: "${chatroomModel.itemAddress}",
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ]),
                    ),
                    subtitle: Text(
                      chatroomModel.lastMsg,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey[300],
                  );
                },
                itemCount: snapshot.hasData ? snapshot.data!.length : 0),
          );
        });
  }
}
