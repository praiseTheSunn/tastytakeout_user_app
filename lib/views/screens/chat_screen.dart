import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/ChatScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/chat_detail_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/chat_items.dart';

import '../../globals.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {}
}

class ChatPage extends StatelessWidget {
  final ChatScreenViewModel viewModel = Get.put(ChatScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenViewModel>(builder: (_) {
      return Scaffold(
        backgroundColor: mainColor,
        appBar: CustomAppBar(
          title: 'Nhắn tin',
        ),
        drawer: CustomDrawer(),
        body: Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.grey.shade300,
                width: 0.0,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: _buildBody(),
          ),
        ),
      );
    });
  }

  Widget _buildBody() {
    return Container(
      color: Colors.white,
      child: Obx(
        () {
          if (viewModel.isLoading.value) {
            String notification = 'Đang tải dữ liệu...';
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/resources/gif/loading.gif',
                  width: 150,
                  height: 150,
                ),
                Text(
                  notification,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ));
          } else {
            var items = viewModel.chatList;
            var time = viewModel.chatListDate;
            String lastMessage = "";
            return ListView.separated(
              padding: EdgeInsets.all(10),
              shrinkWrap: false,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  if (items[index].sender == "BUYER") {
                    lastMessage = "You: " + items[index].newest_message;
                  } else {
                    lastMessage = items[index].newest_message;
                  }
                  return Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff73b5c9),
                    ),
                    child: InkWell(
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color(0xff8692a2);
                        }
                        return Color(0xff73b5c9);
                      }),
                      onTap: () {
                        print("Tapped on container $index");
                        print(items[index]);
                        Get.to(ChatDetailScreen(), arguments: {
                          'chat_room_id': items[index].chat_room_id,
                          'store_id': items[index].store.id,
                          'store_name': items[index].store.name,
                          'store_image_url': items[index].store.image_url,
                          'buyer_image_url': items[index].buyer.image_url,
                        })?.then((value) {
                          viewModel.fetchChatList();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ChatItems(
                          UserName: (items.value)[index].store.name,
                          UserMessage: lastMessage,
                          UserImage: (items.value)[index].store.image_url,
                          UserTime: (time.value)[index],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        padding: EdgeInsets.all(5),
                        child: Image.asset("lib/resources/endOfChat.gif"),
                      ),
                      Text("Không còn tin nhắn nào nữa cả"),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
