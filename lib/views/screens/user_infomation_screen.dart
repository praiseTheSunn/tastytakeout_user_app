import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_box.dart';

class UserInfoController extends GetxController {
  final title = 'UserInfo'.obs;
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
  late ImagePicker _imagePicker;
  late PickedFile _pickedFile;
  late bool _isPicked = false;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _pickedFile = PickedFile('');
    _isPicked = false;
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await _imagePicker.getImage(source: ImageSource.gallery);
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
      appBar: CustomAppBar(
        title: data.userModel.name,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
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
                            image: NetworkImage(
                                "https://t4.ftcdn.net/jpg/04/08/24/43/360_F_408244382_Ex6k7k8XYzTbiXLNJgIL8gssebpLLBZQ.jpg"),
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
                controller: TextEditingController(text: data.userModel.name),
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
                controller: TextEditingController(text: data.userModel.phone),
                decoration: InputDecoration(
                  labelText: "Số điện thoại",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                controller:
                    TextEditingController(text: data.userModel.address[0]),
                decoration: InputDecoration(
                  labelText: "Địa chỉ",
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                child: Text(
                  "LƯU THAY ĐỔI",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
