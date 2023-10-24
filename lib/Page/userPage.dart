import 'package:aplana/Controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Model/usermodel.dart';
import '../Utils/toast.dart';

class UserPage extends StatelessWidget {
  var controller = Get.put(UserController());

  TextEditingController searchController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController editNameController = TextEditingController();
  UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: controller.obx(
      (state) {
        return Column(
          children: [
            Wrap(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 100,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        hintTextDirection: TextDirection.ltr,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        print(searchController.text);
                        controller.update();
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getDailog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 80,
                      color: Colors.grey,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Add User",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.model.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (controller.model[index].name
                        .toString()
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Image.network(controller
                                      .model[index].avatar
                                      .toString()),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "ID: ${controller.model[index].id.toString()}"),
                                    Text(
                                        "Name: ${controller.model[index].name.toString()}"),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () async {
                                      await controller.deleteUser(controller
                                          .model[index].id
                                          .toString());
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      getEditDailog(
                                          context, controller.model[index]);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        );
      },
    ));
  }

  getDailog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              content: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          hintTextDirection: TextDirection.ltr,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (userNameController.text.isNotEmpty) {
                          controller.addUser(userNameController.text);
                          Navigator.pop(context);
                        } else {
                          getToast("Kindly enter user name");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          color: Colors.grey,
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(
                            child: Text(
                              "Add User",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  getEditDailog(BuildContext context, UserModel model) {
    editNameController.text = model.name.toString();
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              content: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: editNameController,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          hintTextDirection: TextDirection.ltr,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (editNameController.text.isNotEmpty) {
                          controller.edit(
                              editNameController.text, model.id.toString());
                          Navigator.pop(context);
                        } else {
                          getToast("Kindly enter user name");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          color: Colors.grey,
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(
                            child: Text(
                              "Update User",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
