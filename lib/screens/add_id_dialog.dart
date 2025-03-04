import 'package:ban_x/common/widgets/custom_standard_button.dart';
import 'package:ban_x/controllers/add_id_dialog_controller.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/widgets/keyboard_dimiss_view.dart';

class AddIdDialog extends StatefulWidget {
  const AddIdDialog({Key? key}) : super(key: key);

  @override
  State<AddIdDialog> createState() => _AddIdDialogState();
}

class _AddIdDialogState extends State<AddIdDialog> {
  final controller = Get.put(AddIdDialogController());


  @override
  void initState() {
    super.initState();
    // Focus the ID text field when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(controller.idFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddIdDialogController>(
        init: AddIdDialogController(),
        builder: (_) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: buildBody(controller)
            ));
  }
}


Widget buildBody(AddIdDialogController controller) {
  return keyboardDismissView(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New ID',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              focusNode: controller.idFocusNode,
              controller: controller.txtIdController,
              style: const TextStyle(color: BanXColors.primaryTextColor),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: BanXString.enterId,
                floatingLabelStyle: TextStyle(color: BanXColors.primaryTextColor),
                labelStyle: TextStyle(color: BanXColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: BanXColors.textFieldBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: BanXColors.primaryTextColor),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextFormField(
              focusNode: controller.nameFocusNode,
              controller: controller.txtNameController,
              style: const TextStyle(color: BanXColors.primaryTextColor),
              decoration: const InputDecoration(
                labelText: BanXString.enterName,
                floatingLabelStyle: TextStyle(color: BanXColors.primaryTextColor),
                labelStyle: TextStyle(color: BanXColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: BanXColors.textFieldBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: BanXColors.primaryTextColor),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedStatus,
                  dropdownColor: BanXColors.primaryBackground,
                  style: const TextStyle(color: Colors.white),
                  items: const [
                    DropdownMenuItem(value: 'ban id', child: Text('Ban ID')),
                    DropdownMenuItem(value: 'scammer', child: Text('Scammer')),
                  ],
                  onChanged: (value) {
                   controller.updateDDLValue(value!);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            ///Add Button
            customStandardBtn(BanXString.add,
                callBack: controller.addUserData),

            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}
