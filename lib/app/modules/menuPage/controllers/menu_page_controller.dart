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
  // Observable for count
  final count = 0.obs;

  // Text Editing Controllers
  TextEditingController editCategoryController = TextEditingController();
  TextEditingController addCategoryController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController editMenuItemController = TextEditingController();

  // Observables for categories and items
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxString itemImage = "".obs;
  RxString itemImageUrl = "".obs;
  final RxString itemEditImage = "".obs;

  // Selected category for adding/editing items
  CategoryModel? addItemSelectedCategory;

  @override
  void onInit() {
    getCategory();
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

  // Method to show add category or item bottom sheet
  void shoeAddCategoryOrItem() {
    Get.bottomSheet(AddCategoryOrMenu());
  }

  // Method to show add category bottom sheet
  void onAddCategoryClick() {
    Get.back();
    Get.bottomSheet(const AddCategory());
  }

  // Method to show edit category bottom sheet
  void onEditCategoryClick({required CategoryModel category}) {
    editCategoryController.text = category.name;
    Get.bottomSheet(EditCategory(category: category));
  }

  // Method to edit category
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

  // Method to delete category
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

  // Method to delete menu item
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

  // Method to navigate to add item details screen
  void gotoAddItemDetailsScreen() {
    Get.back();
    Get.toNamed(Routes.ADD_ITEM_DETAILS, arguments: [false]);
  }

  // Method to increment the count
  void increment() => count.value++;

  // Method to add category
  void addCategory() async {
    if (addCategoryController.text.isEmpty) {
      DialogHelper.showError("Enter the category name");
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
          DialogHelper.showSuccess("Category added successfully");
        } else {
          DialogHelper.showError("Something went wrong!");
        }
      } catch (e) {
        DialogHelper.showError("Category name already added");
      }
    }
  }

  // Method to fetch categories
  Future<void> getCategory() async {
    var response = await APIManager.getCategories();
    List data = response.data["data"];
    categories.value = data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  // Method to show add item bottom sheet
  void showAddItem() {
    Get.back();
    itemImage.value = "";
    itemNameController.text = "";
    addItemSelectedCategory = categories.value[0];
    Get.bottomSheet(AddNewItem());
  }

  // Method to change selected category
  void changeSelectedCategory({required CategoryModel category}) {
    addItemSelectedCategory = category;
  }

  // Method to pick image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      itemImage.value = pickedFile.path;
    }
  }

  // Method to add menu item
  Future<bool> addMenuItem() async {
    if (itemNameController.text.trim().isEmpty) {
      DialogHelper.showError("Item name can't be empty");
      return false;
    }
    if (itemImage.value.isEmpty) {
      DialogHelper.showError("Please select an image");
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
      DialogHelper.showSuccess("Item added successfully");
      await getCategory();
      return true;
    }
    return false;
  }

  // Method to navigate to edit item details screen
  void gotoEditItemDetailsScreen(
      {required MenuItemModel menuItem, required CategoryModel category}) {
    addItemSelectedCategory = category;
    itemImageUrl.value = menuItem.image;
    editMenuItemController.text = menuItem.name;
    debugPrint(menuItem.name);
    Get.to(EditMenuItem(menuItem: menuItem));
  }

  // Method to pick edit image
  Future<void> pickEditImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      itemEditImage.value = pickedFile.path;
    }
  }

  // Method to edit menu item
  Future<void> editItem({required MenuItemModel menu}) async {
    if (editMenuItemController.text.isEmpty) {
      DialogHelper.showError("Item name can't be empty!");
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
