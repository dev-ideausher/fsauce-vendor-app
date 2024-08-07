import 'package:fsauce_vendor_app/app/modules/home/views/home_view.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/views/loyalty_view.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/views/loyalty_cards_view.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/views/menu_page_view.dart';
import 'package:fsauce_vendor_app/app/modules/profile/views/profile_view.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/views/vip_offers_view.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../models/dashboard_monthly_data_model.dart';
import '../../../models/dashboard_weekly_data_model.dart';
import '../../../models/dashboard_yearly_data_model.dart';
import '../../../services/dialog_helper.dart';
import '../../../services/dio/api_service.dart';

enum BottomTab {
  home,
  menu,
  vip,
  loyalty,
  profile,
}

class NavBarController extends GetxController {
  //TODO: Implement NavBarController

  var selectedTab = BottomTab.home.obs;

  var pages = {
    BottomTab.home: const HomeView(),
    BottomTab.menu: const MenuPageView(),
    BottomTab.profile: const ProfileView(),
    BottomTab.vip: const VipOffersView(),
    BottomTab.loyalty: const LoyaltyCardsView(),
  };

  void changeTab(BottomTab tab) {
    selectedTab.value = tab;
  }
}
