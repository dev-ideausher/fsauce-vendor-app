import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/category_model.dart';
import 'package:fsauce_vendor_app/app/models/menu_item_model.dart';
import 'package:fsauce_vendor_app/app/modules/addItemDetails/views/edit_items_details.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/add_category.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/add_category_or_menu.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/add_new_item.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/edit_category.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MenuPageController extends GetxController {

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  TextEditingController editCategoryController = TextEditingController();
  TextEditingController addCategoryController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController editMenuItemController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxString itemImage = "".obs;
  RxString itemImageUrl = "".obs;
  final RxString itemEditImage = "".obs;

  CategoryModel? addItemSelectedCategory;

  void shoeAddCategoryOrItem() {
    Get.bottomSheet(AddCategoryOrMenu());
  }

  void onAddCategoryClick() {
    Get.back();
    Get.bottomSheet(const AddCategory());
  }

  void onEditCategoryClick({required CategoryModel category}) {
    editCategoryController.text = category.name;
    Get.bottomSheet(EditCategory(category: category));
  }

  void editCategory({required CategoryModel category}) async {
    var response = await APIManager.editCategory(
      categoryName: editCategoryController.text.trim(),
      id: category.id,
    );
    if (response.statusCode == 200) {
      Get.back();
      getCategory();
    }
  }

  void deleteCategory({required String id}) async {
    Get.dialog(
      ConfrimationDialog(
        onNoTap: Get.back,
        onYesTap: () async {
          var response = await APIManager.deleteCategory(id: id);
          print(response);
          getCategory();
          Get.back();
        },
        subTitle: StringConstant.deleteCategorySub,
        title: StringConstant.deleteCategory,
      ),
    );
  }

  void deleteItem({required MenuItemModel menuItem}) {
    Get.dialog(
      ConfrimationDialog(
        onNoTap: Get.back,
        onYesTap: () async {
          var response = await APIManager.deleteMenuItem(id: menuItem.id);
          getCategory();
          Get.back();
        },
        subTitle: StringConstant.deleteItemSub,
        title: StringConstant.deleteItem,
      ),
    );
  }

  void gotoAddItemDetailsScreen() {
    Get.back();
    Get.toNamed(Routes.ADD_ITEM_DETAILS, arguments: [false]);
  }

  void addCategory() async {
    if (addCategoryController.text.isEmpty) {
      DialogHelper.showError(StringConstant.enterCategoryName);
      return;
    } else {
      try {
        var response = await APIManager.addCategory(
          categoryName: addCategoryController.text.trim(),
        );
        print(response);
        if (response.statusCode == 200) {
          addCategoryController.text = "";
          getCategory();
          Get.back();
          DialogHelper.showSuccess(StringConstant.categoryAddedSuccessfully);
          return;
        } else {
          DialogHelper.showError(StringConstant.somethingWentWrong);
          return;
        }
      } catch (e) {
        DialogHelper.showError(StringConstant.categoryNameAdded);
        return;
      }
    }
  }

  Future<void> getCategory() async {
    var response = await APIManager.getCategories();
    List data = response.data["data"];
    categories.value = data.map((e) => CategoryModel.fromJson(e)).toList();
    categories.sort((category1, category2) => category1.name.toString().toLowerCase().compareTo(category2.name.toString().toLowerCase()));
    categories.forEach((category){
      category.menu.sort((model1, model2) => model1.name.toString().toLowerCase().compareTo(model2.name.toString().toLowerCase()));
    });
  }

  void showAddItem() {
    Get.back();
    itemImage.value = "";
    itemNameController.text = "";
    addItemSelectedCategory = categories.value[0];
    Get.bottomSheet(const AddNewItem());
  }

  void changeSelectedCategory({required CategoryModel category}) {
    addItemSelectedCategory = category;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      itemImage.value = pickedFile.path;
    }
  }

  Future<bool> addMenuItem() async {
    if (itemNameController.text.trim().isEmpty) {
      DialogHelper.showError(StringConstant.itemNameCantBeEmpty);
      return false;
    }
    if (itemImage.value.isEmpty) {
      DialogHelper.showError(StringConstant.selectAnImage);
      return false;
    }
    var uploadResponse = await APIManager.uploadFile(filePath: itemImage.value);
    String imgUrl = uploadResponse.data["data"];
    var response = await APIManager.addMenuItem(
      itemName: itemNameController.text.trim(),
      categoryId: addItemSelectedCategory!.id,
      imgUrl: imgUrl,
    );

    if (response.statusCode == 200) {
      Get.back();
      DialogHelper.showSuccess(StringConstant.itemAddedSuccessfully);
      await getCategory();
      return true;
    }
    return false;
  }

  void gotoEditItemDetailsScreen(
      {required MenuItemModel menuItem, required CategoryModel category}) {
    addItemSelectedCategory = category;
    itemImageUrl.value = menuItem.image;
    editMenuItemController.text = menuItem.name;
    debugPrint(menuItem.name);
    Get.to(EditMenuItem(menuItem: menuItem));
  }

  Future<void> pickEditImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      itemEditImage.value = pickedFile.path;
    }
  }

  Future<void> editItem({required MenuItemModel menu}) async {
    if (editMenuItemController.text.isEmpty) {
      DialogHelper.showError(StringConstant.itemNameCantBeEmpty);
      return;
    }
    if (itemEditImage.value.isNotEmpty) {
      var uploadResponse =
          await APIManager.uploadFile(filePath: itemEditImage.value);
      itemImageUrl.value = uploadResponse.data["data"];
    }

    await APIManager.editMenuItem(
      itemName: editMenuItemController.text.trim(),
      categoryId: menu.id,
      imgUrl: itemImageUrl.value,
    );
    await getCategory();
  }
}
