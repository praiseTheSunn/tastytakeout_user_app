import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytakeout_user_app/models/dto/ChatModel.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';
import 'package:tastytakeout_user_app/view_models/ChatScreenViewModel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:tastytakeout_user_app/globals.dart';

import '../models/dto/MessageModel.dart';


class ChatDetailScreenViewModel extends GetxController {
  var chatMessage = RxList<MessageModel>();
  final BASE_URL = 'http://$serverIp/chat/';
  final BASE_URL_WS = 'ws://$serverIp/ws/chat/';
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg1OTUxNjI4LCJpYXQiOjE3MDQ1MTE2MjgsImp0aSI6IjU1MGFiOWU0MGM4MTQ2MDNhNmQxMjcxZjRiZjYxNmQ4IiwidXNlcl9pZCI6MTAsInJvbGUiOiJCVVlFUiJ9.Um--pPRWNG7VPh9F7ARYaRIn2Ab5yDvrpZvfsO9_9vA';
  String chatRoom = '';
  late WebSocketChannel channel;
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  String sender_url = '';
  String receiver_url = '';
  var isLoading = true.obs;
  var partnerIsTyping = false.obs;
  bool sended = false;

  ChatDetailScreenViewModel(String chatRoom, String sender_url, String receiver_url) {
    this.chatRoom = chatRoom;
    this.sender_url = sender_url;
    this.receiver_url = receiver_url;
  }

  void addTextControllerListener() {
    messageController.addListener(() {
      if (messageController.text.length > 0) {
        if (sended == false) {
          sended = true;
          sendMessage(''); // Send empty message to server
        }// Send empty message to server
      } else {
        if (sended == true) {
          sended = false;
          sendMessage(''); // Send empty message to server
        }
      }
    });
  }

  @override
  Future<void> onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    getChatMessages();
    channel = WebSocketChannel.connect(
      Uri.parse(BASE_URL_WS + chatRoom + '/?token=' + token),
    );
    startListening();
    addTextControllerListener();
    super.onInit();
  }

  void scrollToBottom(int time) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: time),
      curve: Curves.easeOut,
    );
  }

  void scrollToTop(int time) {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: time),
      curve: Curves.easeOut,
    );
  }

  Future<void> getChatMessages() async {
    print(BASE_URL + chatRoom);
    try {
      isLoading(true);
      final response = await get(
        Uri.parse(BASE_URL + chatRoom),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization' : 'Bearer ' + token
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error fetching chat messages');
      } else {
        List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        chatMessage.value.insertAll(0,json.map((e) => MessageModel.fromJson(e)).toList());
        chatMessage.value = chatMessage.value.reversed.toList();
      }
    } catch (e) {
      print('Error in getChatMessages ' + e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> postChatMessage(String message) async {
    final url = Uri.parse(BASE_URL + chatRoom + '/');
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer ' + token
    };
    final jsonBody = json.encode({
      'message': message,
    });

    try {
      final response = await post(url, headers: headers, body: jsonBody);
      if (response.statusCode != 200) {
        throw Exception('Error posting chat message');
      } else {
        print(response.body);
      }
      Get.find<ChatScreenViewModel>().fetchChatList();
    } catch (e) {
      print('Error in postChatMessage ' + e.toString());
    }
  }

  void startListening() {
    channel.stream.handleError((error) {
      print('Có lỗi xảy ra: $error');
    }).listen((message) {
      MessageModel messageModel = MessageModel.fromJsonWithoutImage(jsonDecode(message));
      if (messageModel.message.length == 0 ) {
        if (messageModel.sender == 'SELLER')
          partnerIsTyping.value = !partnerIsTyping.value;
      } else {
        if (messageModel.sender == 'SELLER') {
          partnerIsTyping.value = false;
          sended = false;
        }
        if (messageModel.sender == 'BUYER') {
          messageModel.sender_url = sender_url;
        } else {
          messageModel.sender_url = receiver_url;
        }
        Get.find<ChatScreenViewModel>().fetchChatList();
        chatMessage.insert(0,messageModel);
        print('Tin nhắn mới: $message');
      }
      if (partnerIsTyping.value) {
        print('Đối phương đang nhập tin nhắn');
      } else {
        print('Đối phương đã gửi tin nhắn');
      }
    }, onDone: () {
      print('WebSocket kết nối đã đóng');
    });
  }

  void sendMessage(String text) {
    // Send message to server and add new message to database
    final message = json.encode({'message': text,'role' : 'BUYER'});
    if (text.length > 0) {
      postChatMessage(text);
    }
    channel.sink.add(message);
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }


}

