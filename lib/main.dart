import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fsauce_vendor_app/app/modules/pushNotification/views/notification_service.dart';
import 'package:fsauce_vendor_app/app/modules/splash/binding/splash_binding.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:fsauce_vendor_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/services/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey =
      "pk_test_51IDxNdKlUbZkAAt635jlWKPvpeBvKQmkiqQr91KFHKzlEp5DzO8T9DEAOTpdfCUPihlTBZ7kB2gb4yFAYwQOevLk00ekRk7tuH";
  Stripe.merchantIdentifier = "foodsauciety@2024";
  // ✅ Let stacked_firebase_auth handle initialization internally
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase already initialized or handled by another service: $e");
  }
  Get.put(NotificationService());
  await NotificationService.to.init();
  await initGetServices();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  Get.lazyPut<Auth>(() => Auth());

  return runApp(GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: GetMaterialApp(
      // theme: AppTheme.light,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffFAFAFA),
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: Colors.red)),
      // darkTheme: AppTheme.dark,
      defaultTransition: Transition.fade,
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      // translationsKeys: AppTranslation.translations,
      initialRoute: Routes.SPLASHVIEW,
      initialBinding: SplashBinding(),
      getPages: AppPages.routes,
    ),
  ));
}

Future<void> initGetServices() async {
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
  print(Get.find<GetStorageService>().encjwToken);
}
