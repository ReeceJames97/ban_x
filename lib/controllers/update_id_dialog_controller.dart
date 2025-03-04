import 'package:ban_x/services/api_services.dart';
import 'package:ban_x/utils/common_utils.dart';
import 'package:ban_x/utils/dialog_utils/dialog.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateIdDialogController extends GetxController {
  static UpdateIdDialogController get instance => Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DocumentSnapshot document;

  final TextEditingController txtIdController = TextEditingController();
  final TextEditingController txtNameController = TextEditingController();
  String selectedStatus = 'ban id';
  final ApiServices apiServices = ApiServices();
  FocusNode idFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();

  UpdateIdDialogController({required this.document});

  @override
  void onInit() {
    super.onInit();
    initialization();
  }

  Future<void> initialization() async{
    final data = document.data() as Map<String, dynamic>;
    setData(document.id, data['id'] ?? '', data['name'] ?? '', data['status'] ?? 'ban id');
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

  String? documentId;

  void setData(String docId, String id, String name, String status) {
    documentId = docId;
    txtIdController.text = id;
    txtNameController.text = name;
    selectedStatus = status;
    update();
  }

  Future<void> updateUserData() async {
    try {
      if (documentId == null) {
        HelperFunctions.showSnackBar("Error: No document ID found");
        return;
      }

      showLoadingDialog();

      String id = getEmptyString(txtIdController.text.trim());
      String name = getEmptyString(txtNameController.text.trim());
      String status = selectedStatus.isNotEmpty == true ? selectedStatus : "ban id";

      Map<String, dynamic> userData = {
        "id": id,
        "name": name,
        "status": status,
        "createdAt": FieldValue.serverTimestamp(),
      };

      await apiServices.updateBanId(documentId!, userData);

      HelperFunctions.showSnackBar("Ban ID updated successfully!");
      Get.back();
    } catch (e) {
      HelperFunctions.showSnackBar("Error: ${e.toString()}");
    } finally {
      hideDialog();
    }
  }
}