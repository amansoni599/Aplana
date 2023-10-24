import 'package:aplana/Model/usermodel.dart';
import 'package:aplana/api_services.dart';
import 'package:get/get.dart';

class UserController extends GetxController with StateMixin {
  ApiService apiservice = ApiService();
  List<UserModel> model = [];

  @override
  Future<void> onInit() async {
    await getUser();

    super.onInit();
  }

  getUser() async {
    var res = await apiservice.getUserDetails();
    if (res != null) {
      model = res;
      change(null, status: RxStatus.success());
    }
  }

  deleteUser(String id) async {
    change(null, status: RxStatus.loading());
    var res = await apiservice.deleteUserDetails(id);
    await getUser();
  }

  addUser(String name) async {
    change(null, status: RxStatus.loading());
    UserModel model = UserModel(name: name);
    var res = await apiservice.addUsersDetails(model);
    await getUser();
  }

  edit(String name, String id) async {
    change(null, status: RxStatus.loading());
    UserModel model = UserModel(name: name);
    var res = await apiservice.editUsersDetails(name, id);
    await getUser();
  }
}
