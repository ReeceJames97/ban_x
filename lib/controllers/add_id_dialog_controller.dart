import 'package:ban_x/services/api_services.dart';
import 'package:ban_x/utils/common_utils.dart';
import 'package:ban_x/utils/dialog_utils/dialog.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIdDialogController extends GetxController {
  static AddIdDialogController get instance => Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController txtIdController = TextEditingController();
  final TextEditingController txtNameController = TextEditingController();
  String selectedStatus = 'ban id';
  final ApiServices apiServices = ApiServices();
  FocusNode idFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    initialization();
  }

  Future<void> initialization() async{

  }

  @override
  void dispose() {
    txtIdController.dispose();
    txtNameController.dispose();
    idFocusNode.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  void updateDDLValue(String value){
    selectedStatus = value;
    update();
  }

  Future<void> addUserData() async {
    try {
      showLoadingDialog();

      String id = getEmptyString(txtIdController.text.trim());
      String name = getEmptyString(txtNameController.text.trim());
      String status = selectedStatus.isNotEmpty == true ? selectedStatus : "ban id";

      Map<String, dynamic> userData = {
        "id": id,
        "name": name,
        "status": status,
        "createdAt": FieldValue.serverTimestamp(), // Optional: Adds a timestamp
      };

      await apiServices.addBanId(userData);
      HelperFunctions.showSnackBar("Ban ID added successfully!");

      txtIdController.clear();
      txtNameController.clear();
      selectedStatus = 'ban id';
      update();
      hideDialog();
    } catch (e) {
      txtIdController.clear();
      txtNameController.clear();
      selectedStatus = 'ban id';
      update();
      hideDialog();
      HelperFunctions.showSnackBar("Error: ${e.toString()}");
    } finally {
      hideDialog();
    }
  }
}