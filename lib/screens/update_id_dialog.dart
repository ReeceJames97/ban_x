import 'package:ban_x/common/widgets/custom_standard_button.dart';
import 'package:ban_x/controllers/update_id_dialog_controller.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/widgets/keyboard_dimiss_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateIdDialog extends StatefulWidget {
  final DocumentSnapshot document;
  const UpdateIdDialog({Key? key, required this.document}) : super(key: key);

  @override
  State<UpdateIdDialog> createState() => _UpdateIdDialogState();
}

class _UpdateIdDialogState extends State<UpdateIdDialog> {
  late final UpdateIdDialogController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(UpdateIdDialogController(document: widget.document));
    // Focus the ID text field when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(controller.idFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateIdDialogController>(
        init: controller,
        builder: (_) =>
            SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.85,
                child: buildBody(controller)
            ));
  }

//   void showUpdateItemBottomSheet(BuildContext context, DocumentSnapshot document) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       useSafeArea: true,
//       backgroundColor: BanXColors.primaryBackground,
//       constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.85
//       ),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => UpdateIdDialog(document: document),
//     );
//   }
// }


  Widget buildBody(UpdateIdDialogController controller) {
    return keyboardDismissView(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(Get.context!)
                .viewInsets
                .bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Update ID',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
                  floatingLabelStyle: TextStyle(
                      color: BanXColors.primaryTextColor),
                  labelStyle: TextStyle(color: BanXColors.secondaryTextColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BanXColors.textFieldBorderColor),
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
                  floatingLabelStyle: TextStyle(
                      color: BanXColors.primaryTextColor),
                  labelStyle: TextStyle(color: BanXColors.secondaryTextColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BanXColors.textFieldBorderColor),
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
                      DropdownMenuItem(
                          value: 'scammer', child: Text('Scammer')),
                    ],
                    onChanged: (value) {
                      controller.updateDDLValue(value!);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              ///Update Button
              customStandardBtn(BanXString.update,
                  callBack: controller.updateUserData),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
