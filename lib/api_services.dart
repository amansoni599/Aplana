import 'dart:convert';

import 'package:aplana/Model/usermodel.dart';
import 'package:aplana/Utils/toast.dart';
import 'package:http/http.dart' as http;

class ApiService {
  getUserDetails() async {
    var response = await http
        .get(Uri.parse("https://6537dfc2a543859d1bb0f94e.mockapi.io/Users"));
    if (response.statusCode == 200) {
      return List<UserModel>.from(
          json.decode(response.body).map((x) => UserModel.fromJson(x)));
    } else {
      getToast("Something weng to wrong");
    }
  }

  deleteUserDetails(String id) async {
    var response = await http.delete(
        Uri.parse("https://6537dfc2a543859d1bb0f94e.mockapi.io/Users/$id"));
    if (response.statusCode == 200) {
      return true;
    } else {
      getToast("Something weng to wrong");
    }
  }

  addUsersDetails(UserModel model) async {
    var response = await http.post(
        Uri.parse("https://6537dfc2a543859d1bb0f94e.mockapi.io/Users"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({"name": model.name}));
    if (response.statusCode == 200) {
      return true;
    } else {
      getToast("Something weng to wrong");
    }
  }

  editUsersDetails(String name, String id) async {
    var response = await http.put(
        Uri.parse("https://6537dfc2a543859d1bb0f94e.mockapi.io/Users/$id"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({"name": name}));
    if (response.statusCode == 200) {
      return true;
    } else {
      getToast("Something weng to wrong");
    }
  }
}
