import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/data_sources/user_source.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_box.dart';

class UserInfoController extends GetxController {
  final title = 'UserInfo'.obs;
  var userModel = UserModel().obs;
  var isLoaded = false.obs;

  Future<void> getUserInfo() async {
    if (userModel.value.name == "") {
      isLoaded.value = false;
    }

    userModel.value = await UserSource().getUserInfo();
    isLoaded.value = true;
  }

  Future<void> updateUserInfo() async {
    var res = await UserSource().patchUserInfo(userModel.value);
    getUserInfo();
  }
}

class UserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController());
  }
}

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  // final UserInfoController _userInfoController = Get.find<UserInfoController>();
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  late ImagePicker _imagePicker;
  late XFile _pickedFile;
  late bool _isPicked = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userInfoController.getUserInfo();
    _imagePicker = ImagePicker();
    _pickedFile = XFile('');
    _isPicked = false;
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedFile = pickedFile;
          _isPicked = true;
        });
        print("Đường dẫn ảnh: ${_pickedFile.path}");
      }
    } catch (e) {
      print("Lỗi khi chọn ảnh: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Người dùng'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (_userInfoController.isLoaded.value == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _nameController.text = _userInfoController.userModel.value.name;
            _emailController.text = _userInfoController.userModel.value.email;
            _addressController.text =
                _userInfoController.userModel.value.address;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: _isPicked == true
                              ? DecorationImage(
                                  image: FileImage(File(_pickedFile.path)),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(_userInfoController
                                      .userModel.value.avatar_url),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Tên người dùng",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: "Địa chỉ",
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      _userInfoController.userModel.value.update(
                        name: _nameController.text,
                        email: _emailController.text,
                        address: _addressController.text,
                      );

                      _userInfoController.updateUserInfo();
                      Navigator.pop(context);
                      Get.put(UserInfoController());
                      Get.to(UserInfoPage());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      child: Text(
                        "LƯU THAY ĐỔI",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
