import 'package:ban_x/models/ban_item_model.dart';
import 'package:ban_x/screens/update_id_dialog.dart';
import 'package:ban_x/services/api_services.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final txtSearchController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  RxList<BanItem> items = <BanItem>[].obs;
  RxString searchQuery = ''.obs;
  RxList<BanItem> filteredItems = <BanItem>[].obs;
  final ApiServices apiServices = ApiServices();
  Stream<QuerySnapshot>? banIdStream;
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  void onInit() {
    super.onInit();
    getAllBanIdList();
  }

  @override
  void dispose() {
    txtSearchController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  Future<void> getAllBanIdList() async {
    try {
      final stream = await apiServices.getBanIds();
      banIdStream = stream;
      update();
      
      // Cancel any existing subscription
      await for (var snapshot in stream) {
        if (!refreshController.isRefresh) break; // Exit if not refreshing
        
        items.value = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return BanItem(
            id: data['id'] ?? '',
            name: data['name'] ?? '',
            status: data['status'] ?? 'ban id',
            createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          );
        }).toList();
        
        filterItems();
        refreshController.refreshCompleted();
        update();
        break; // Exit after first update
      }
    } catch (e) {
      refreshController.refreshFailed();
      HelperFunctions.showSnackBar("Error loading ban IDs: ${e.toString()}");
    }
  }

  void filterItems() {
    if (searchQuery.value.isEmpty) {
      filteredItems.value = items;
    } else {
      filteredItems.value = items.where((item) {
        return item.id.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            item.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
    update(); // Trigger UI update when filtered items change
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterItems();
  }

  void showUpdateItemBottomSheet(BuildContext context, DocumentSnapshot document) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: BanXColors.primaryBackground,
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => UpdateIdDialog(document: document),
    );
  }




  void deleteItem(DocumentSnapshot item) async {
    try {
      await apiServices.deleteBanId(item.id);
      HelperFunctions.showSnackBar("Item deleted successfully");
      getAllBanIdList();
    } catch (e) {
      HelperFunctions.showSnackBar("Error deleting item: ${e.toString()}");
    }
  }
}