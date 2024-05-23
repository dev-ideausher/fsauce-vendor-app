import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/add_category.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/add_category_or_menu.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/add_new_item.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MenuPageController extends GetxController {
  //TODO: Implement MenuPageController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void shoeAddCategoryOrItem() {
    Get.bottomSheet(AddCategoryOrMenu());
  }

  void onAddCategoryClick() {
    Get.back();
    Get.bottomSheet(
      AddCategory(
        isEdit: false,
      ),
    );
  }

  void onEditCategoryClick() {
    Get.bottomSheet(
      AddCategory(
        isEdit: true,
      ),
    );
  }

  void deleteCategory() {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {},
      subTitle: StringConstant.deleteCategorySub,
      title: StringConstant.deleteCategory,
    ));
  }

  void deleteItem() {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {},
      subTitle: StringConstant.deleteItemSub,
      title: StringConstant.deleteItem,
    ));
  }

  void showAddItem() {
    Get.back();
    Get.bottomSheet(AddNewItem());
  }

  void gotoAddItemDetailsScreen() {
    Get.back();
    Get.toNamed(Routes.ADD_ITEM_DETAILS, arguments: [false]);
  }

  void gotoEditItemDetailsScreen() {
    Get.toNamed(Routes.ADD_ITEM_DETAILS, arguments: [true]);
  }

  void increment() => count.value++;
}
