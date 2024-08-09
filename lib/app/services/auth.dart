import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'storage.dart';
import 'dart:developer';
import 'dialog_helper.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Auth extends GetxService {
  final auth = FirebaseAuthenticationService();
  final _facebookLogin = FacebookAuth.instance;
  AuthCredential? _pendingCredential;
  final _firebaseAuth = FirebaseAuth.instance;

  google() async {
    //TODO: do the required setup mentioned in https://pub.dev/packages/google_sign_in
    final _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
    await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      debugPrint('Process is canceled by the user');
      DialogHelper.showError("Google sign cancelled by user");
      return;
    }
    final googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    if(userCredential.user != null){
      await handleGetContact();
    }
  }

  apple() async {
    //TODO: do the required setup mentioned in https://pub.dev/packages/sign_in_with_apple
    final result = await auth
        .signInWithApple(
            //TODO: add your own handler id from firebase console
            appleRedirectUri:
                'https://stacked-firebase-auth-test.firebaseapp.com/__/auth/handler',
            appleClientId: '')
        .then((value) async {
      await handleGetContact();
    });
    print('Apple : ${await result.user?.getIdToken()}');
  }

  Future<dynamic> loginEmailPass({required String email, required String pass}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      await handleGetContact();
    }).catchError((e) {
      if(e is FirebaseAuthException){
        DialogHelper.showError(e.message ?? "Something went wrong");
      }
      print("This is from auth, loginEmailPass");
      print(e);
    });
    // print('EmailPass : ${await result.user?.getIdToken()}');
  }

  updatePassword({required String newPassword}) async{
    final result = await auth.updatePassword(newPassword).then((value) async{
      await handleGetContact();
    });
  }

  createEmailPass({required String email, required String pass}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      await handleGetContact();
    }).catchError((e) {
      if(e is FirebaseAuthException){
        DialogHelper.showError(e.message ?? "Something went wrong");
      }
      print("This is from auth, createEmailPass");
      print(e);
    });
    // await auth
    //     .createAccountWithEmail(email: email, password: pass)
    //     .then((value) async {
    //   await handleGetContact();
    // });
    // print('EmailPass : ${await result.user?.getIdToken()}');
  }

//phone number with country code
  mobileOtp({required String phoneno}) async {
    await auth.requestVerificationCode(
      phoneNumber: phoneno,
      onCodeSent: (verificationId) => print(verificationId),
    );
  }

  sendVerificationMail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<bool> sendResetPasswordMail({required String email}) async {
    final result = await auth.sendResetPasswordLink(email);
    if(result is bool){
      if(result){
        return true;
      } else{
        return false;
      }
    }
    return false;
  }

  verifyMobileOtp({required String otp}) async {
    final result = await auth.authenticateWithOtp(otp).then((value) async {
      await handleGetContact();
    });
    print('Mobile Otp : ${await result.user?.getIdToken()}');
  }

  facebook() async {
    //TODO: do the required setup mentioned in https://pub.dev/packages/flutter_facebook_auth
    await signInWithFacebook().then((value) async {
      await handleGetContact();
    });
  }

  Future<FirebaseAuthenticationResult> signInWithFacebook() async {
    try {
      LoginResult fbLogin = await _facebookLogin.login();
      // log?.v('Facebook Sign In complete. \naccessToken:${accessToken.token}');

      final OAuthCredential facebookCredentials =
          FacebookAuthProvider.credential(fbLogin.accessToken!.token);

      var result =
          await _firebaseAuth.signInWithCredential(facebookCredentials);

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user?.linkWithCredential(_pendingCredential!);
      }

      return FirebaseAuthenticationResult(user: result.user);
    } catch (e) {
      // log?.e(e);
      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    }
  }

  Future<void> handleGetContact() async {
    final mytoken = await _firebaseAuth.currentUser!.getIdToken(true);
    final fireUid = _firebaseAuth.currentUser!.uid;

    Get.find<GetStorageService>().encjwToken = mytoken!;
    Get.find<GetStorageService>().setFirebaseUid = fireUid;
    log(Get.find<GetStorageService>().encjwToken);
    debugPrint('i am user id${Get.find<GetStorageService>().getFirebaseUid}');
  }

  Future<void> logOutUser() async {
    DialogHelper.showLoading();
    // erase the user's token and data in GetStorageService
    Get.find<GetStorageService>().logout();
    // firebase logout
    auth.logout();
    // navigate to login page
    // await Get.offAllNamed(Routes.LOGIN);
    await DialogHelper.hideDialog();
  }
}
