import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:kltn_mobile/API/api_service.dart';
// import 'package:kltn_mobile/Model/user_register.dart';

class AuthBloc {
  StreamController nameController = StreamController();
  StreamController dateController = StreamController();
  StreamController phoneController = StreamController();
  StreamController addressController = StreamController();
  StreamController genderController = StreamController();
  StreamController cICController = StreamController();
  StreamController emailController = StreamController();
  StreamController passController = StreamController();

  StreamController gpaController = StreamController();
  StreamController desController = StreamController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode cICFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  FocusNode get phonefocusnode => phoneFocusNode;

  FocusNode get addressfocusnode => addressFocusNode;

  FocusNode get genderfocusnode => genderFocusNode;

  FocusNode get cICfocusnode => cICFocusNode;

  FocusNode get emailfocusnode => emailFocusNode;

  FocusNode get passfocusnode => passFocusNode;

  FocusNode get namefocusnode => nameFocusNode;

  Stream get nameStream => nameController.stream;

  // Stream get dateStream => dateController.stream;
  Stream get phoneStream => phoneController.stream;

  Stream get addressStream => addressController.stream;

  Stream get genderStream => genderController.stream;

  Stream get cICStream => cICController.stream;

  Stream get emailStream => emailController.stream;

  Stream get passStream => passController.stream;

  Stream get gpaStream => gpaController.stream;

  Stream get desStream => desController.stream;

  // Future<void> getUser() async {
  //   lstUser = await ReadData().ListUser();
  // }

  Future<bool> isValid(String name, String dob, String phone, String address,
      String gender, String cic, String email, String pass) async {
    if (name.isEmpty) {
      nameController.sink.addError("*Nhập họ tên");
      nameFocusNode.requestFocus();
      return false;
    }
    nameController.sink.add("");

    if (phone.isEmpty) {
      phoneController.sink.addError("*Nhập số điện thoại");
      phoneFocusNode.requestFocus();
      return false;
    }
    phoneController.sink.add("");

    if (phone.length != 10) {
      phoneController.sink.addError("*Số điện thoại gồm 10 kí tự");
      phoneFocusNode.requestFocus();
      return false;
    }
    phoneController.sink.add("");

    if (address.isEmpty) {
      addressController.sink.addError("*Nhập địa chỉ");
      addressFocusNode.requestFocus();
      return false;
    }
    addressController.sink.add("");

    if (!(gender == "Nam" || gender == "Nữ")) {
      genderController.sink.addError("*Vui lòng chọn giới tính ");
      genderFocusNode.requestFocus();
      return false;
    }
    genderController.sink.add("");

    if (cic.isEmpty || cic.length < 9) {
      cICController.sink.addError("*CCCD phải từ 9 chữ số");
      cICFocusNode.requestFocus();
      return false;
    }
    cICController.sink.add("");

    RegExp emailRegex = RegExp(
        r'.+@.+'); // Biểu thức chính quy kiểm tra có ít nhất một ký tự trước và sau ký tự '@'
    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      emailController.sink.addError("*Email không hợp lệ");
      emailFocusNode.requestFocus();
      return false;
    }
    emailController.sink.add("");

    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp digitRegex = RegExp(r'\d');
    RegExp specialCharRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    bool isPasswordValid = uppercaseRegex.hasMatch(pass) &&
        lowercaseRegex.hasMatch(pass) &&
        digitRegex.hasMatch(pass) &&
        specialCharRegex.hasMatch(pass) &&
        pass.length >= 10;

    if (!isPasswordValid) {
      passController.sink.addError(
          "*Từ 10 kí tự( gồm chữ cái hoa, thường, số và kí tự đặc biệt");
      passFocusNode.requestFocus();
      return false;
    }
    passController.sink.add("");

    return true;
  }

  Future<bool> isValid2(String schoolCate, String schoolName, String eng,
      String gpa, String des) async {
    try {
      // Thực hiện gửi yêu cầu API đăng ký
      final response = await http.post(
        Uri.parse(
            'https://kltn-demo-deploy-admin.vercel.app/api/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          // Gửi dữ liệu cần thiết đến API
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        return true;
      } else {
        // ignore: prefer_interpolation_to_compose_strings
        print("statusCode " + response.statusCode.toString());
        await showToast("Đăng ký thất bại!");
        return false;
      }
    } catch (e) {
      print("Exception occurred while registering: $e");
      return false;
    }
  }

  void errorEmailExist() {
    emailController.sink.addError("*Email đã được sử dụng");
  }

  void dispose() {
    emailController.close();
    phoneController.close();
    addressController.close();
    genderController.close();
    cICController.close();
    emailController.close();
  }

  Future<void> showToast(String msg) async {
    await Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: const Color(0xFF7D1F1F),
        fontSize: 16.0);
  }
}
