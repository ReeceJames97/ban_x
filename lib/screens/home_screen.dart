import 'package:ban_x/common/widgets/keyboard_dimiss_view.dart';
import 'package:ban_x/common/widgets/loading_view.dart';
import 'package:ban_x/common/widgets/empty_view_with_retry.dart';
import 'package:ban_x/controllers/home_screen_controller.dart';
import 'package:ban_x/screens/add_id_dialog.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/dialog_utils/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: BanXColors.primaryBackground,
      body: GetBuilder<HomeScreenController>(
          init: controller,
          builder: (_) => keyboardDismissView(child: _buildBody(context))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemBottomSheet(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () async {
        try {
          await controller.getAllBanIdList();
          controller.refreshController.refreshCompleted();
        } catch (e) {
          controller.refreshController.refreshFailed();
        }
      },
      enablePullDown: true,
      header: const WaterDropHeader(
        waterDropColor: Colors.blueAccent,
        complete: Icon(Icons.check, color: Colors.blueAccent),
        failed: Icon(Icons.close, color: Colors.red),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        color: BanXColors.primaryBackground,
        child: Column(
          children: [
            /// Search TextField
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller.txtSearchController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => controller.updateSearchQuery(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Search by ID',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.txtSearchController.clear();
                      controller.updateSearchQuery('');
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                    )),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BanXColors.textFieldBorderColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: BanXColors.primaryTextColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // ListView with StreamBuilder
            Expanded(
              child: StreamBuilder(
                stream: controller.banIdStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                    return const LoadingView();
                  }
                  if (snapshot.hasError) {
                    return EmptyViewWithRetry(
                      message: 'Error: ${snapshot.error}',
                      onRetry: () => controller.getAllBanIdList(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return EmptyViewWithRetry(
                      message: 'No items found',
                      onRetry: () => controller.getAllBanIdList(),
                    );
                  }

                  final docs = snapshot.data!.docs;
                  final filteredDocs = docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final id = data['id']?.toString().toLowerCase() ?? '';
                    final name = data['name']?.toString().toLowerCase() ?? '';
                    final query = controller.txtSearchController.text.trim().toLowerCase();
                    return query.isEmpty || id.contains(query) || name.contains(query);
                  }).toList();

                  if (filteredDocs.isEmpty) {
                    return EmptyViewWithRetry(
                      message: controller.txtSearchController.text.isEmpty
                        ? 'No items found'
                        : 'No matching items found',
                      onRetry: () => controller.getAllBanIdList(),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      final data = filteredDocs[index].data() as Map<String, dynamic>;
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          data['name']?.toString().isNotEmpty == true ? data['name'] : 'Anonymous',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: data['status'] == 'ban id'
                                                ? Colors.red.withValues(alpha: 0.2)
                                                : Colors.orange.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            data['status'] ?? '',
                                            style: TextStyle(
                                              color: data['status'] == 'ban id'
                                                  ? Colors.red
                                                  : Colors.orange,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'ID: ${data['id']}',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      controller.showUpdateItemBottomSheet(context, filteredDocs[index]);
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    splashRadius: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      showConfirmDialog(() => controller.deleteItem(filteredDocs[index]));
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    splashRadius: 24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildBanListsWidget() {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () async {
        try {
          await controller.getAllBanIdList();
          controller.refreshController.refreshCompleted();
        } catch (e) {
          controller.refreshController.refreshFailed();
        }
      },
      enablePullDown: true,
      header: const WaterDropHeader(
        waterDropColor: Colors.white,
        complete: Icon(Icons.check, color: Colors.white),
        failed: Icon(Icons.close, color: Colors.red),
      ),
      child: StreamBuilder(
        stream: controller.banIdStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return LoadingView();
          }
          if (snapshot.hasError) {
            return EmptyViewWithRetry(
              message: 'Error: ${snapshot.error}',
              onRetry: () => controller.getAllBanIdList(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return EmptyViewWithRetry(
              message: 'No items found',
              onRetry: () => controller.getAllBanIdList(),
            );
          }

          final docs = snapshot.data!.docs;
          final filteredDocs = docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final id = data['id']?.toString().toLowerCase() ?? '';
            final name = data['name']?.toString().toLowerCase() ?? '';
            final query = controller.txtSearchController.text.toLowerCase();
            return id.contains(query) || name.contains(query);
          }).toList();

          if (filteredDocs.isEmpty) {
            return EmptyViewWithRetry(
              message: 'No matching items found',
              onRetry: () => controller.getAllBanIdList(),
            );
          }

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot item = filteredDocs[index];
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item['name']?.toString().isNotEmpty == true ? item['name'] : 'Anonymous',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: item['status'] == 'ban id'
                                        ? Colors.red.withValues(alpha: 0.2)
                                        : Colors.orange.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item['status'],
                                    style: TextStyle(
                                      color: item['status'] == 'ban id'
                                          ? Colors.red
                                          : Colors.orange,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID: ${item['id']}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.blue,
                              size: 25,
                            ),
                            onPressed: () {
                              controller.showUpdateItemBottomSheet(context, item);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            splashRadius: 24,
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 25,
                            ),
                            onPressed: () {
                              showConfirmDialog(() => controller.deleteItem(item));
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            splashRadius: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddItemBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
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
      builder: (context) => const AddIdDialog(),
    );
    controller.getAllBanIdList();
  }

}
