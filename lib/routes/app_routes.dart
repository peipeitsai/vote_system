import 'package:vote_test/presentation/vote_list_screen/vote_list_screen.dart';
import 'package:vote_test/presentation/vote_list_screen/binding/vote_list_binding.dart';
import 'package:vote_test/presentation/splash_screen/splash_screen.dart';
import 'package:vote_test/presentation/splash_screen/binding/splash_screen_binding.dart';
import 'package:vote_test/presentation/app_key_screen/app_key_screen.dart';
import 'package:vote_test/presentation/app_key_screen/binding/app_key_binding.dart';
import 'package:vote_test/presentation/app_key_success_screen/app_key_success_screen.dart';
import 'package:vote_test/presentation/app_key_success_screen/binding/app_key_success_binding.dart';
import 'package:vote_test/presentation/circular_screen/circular_screen.dart';
import 'package:vote_test/presentation/circular_screen/binding/circular_screen_binding.dart';
import 'package:vote_test/presentation/identity_authentication_success_screen/identity_authentication_success_screen.dart';
import 'package:vote_test/presentation/identity_authentication_success_screen/binding/identity_authentication_success_binding.dart';
import 'package:vote_test/presentation/vote_success_screen/vote_success_screen.dart';
import 'package:vote_test/presentation/vote_success_screen/binding/vote_success_binding.dart';
import 'package:vote_test/presentation/menu_screen/menu_screen.dart';
import 'package:vote_test/presentation/menu_screen/binding/menu_binding.dart';
import 'package:vote_test/presentation/active_info_screen/active_info_screen.dart';
import 'package:vote_test/presentation/active_info_screen/binding/active_info_binding.dart';
import 'package:vote_test/presentation/activity_check_candi_screen/activity_check_candi_screen.dart';
import 'package:vote_test/presentation/activity_check_candi_screen/binding/activity_check_candi_binding.dart';
import 'package:vote_test/presentation/identity_authentication_fail_screen/identity_authentication_fail_screen.dart';
import 'package:vote_test/presentation/identity_authentication_fail_screen/binding/identity_authentication_fail_binding.dart';
import 'package:vote_test/presentation/home_screen/home_screen.dart';
import 'package:vote_test/presentation/home_screen/binding/home_binding.dart';
import 'package:vote_test/presentation/identity_authentication_screen/identity_authentication_screen.dart';
import 'package:vote_test/presentation/identity_authentication_screen/binding/identity_authentication_binding.dart';
import 'package:vote_test/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:vote_test/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:vote_test/presentation/connect_metamask_screen/connect_metamask_screen.dart';
import 'package:vote_test/presentation/connect_metamask_screen/binding/connect_metamask_binding.dart';
import 'package:get/get.dart';
import 'package:vote_test/presentation/result_screen/result_screen.dart';
import 'package:vote_test/presentation/result_screen/binding/result_binding.dart';
import 'package:vote_test/presentation/home_page_after_login_screen/home_page_after_login_screen.dart';
import 'package:vote_test/presentation/home_page_after_login_screen/binding/home_page_after_login_binding.dart';
import 'package:vote_test/presentation/activity_check_revote/binding/activity_check_revote_binding.dart';
import 'package:vote_test/presentation/activity_check_revote/activity_check_revote.dart';
import 'package:vote_test/presentation/revote_success_screen/binding/revote_success_binding.dart';
import 'package:vote_test/presentation/revote_success_screen/revote_success_screen.dart';
import 'package:vote_test/presentation/phone_auth_screen/phone_auth_screen.dart';

import 'package:flutter/material.dart';
import 'package:vote_test/utils/helperfunctions.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';

import 'package:vote_test/presentation/goto_result_screen/goto_result_screen.dart';
import 'package:vote_test/presentation/goto_result_screen/binding/goto_result_binding.dart';




class AppRoutes {
  static String voteCheck3Screen = '/vote_check3_screen';

  static String appKeyScreen = '/app_key_screen';

  static String appKeySuccessScreen = '/app_key_success_screen';

  static String splashScreen = '/splash_screen';

  static String circularScreen = '/circular_screen';

  static String voteListScreen = '/vote_list_screen';

  static String identityAuthenticationSuccessScreen =
      '/identity_authentication_success_screen';

  static String voteSuccessScreen = '/vote_success_screen';

  static String connectMetamaskScreen ='/connect_metamask_screen';

  static String menuScreen = '/menu_screen';

  static String activeInfoScreen = '/active_info_screen';

  static String phoneAuthScreen = '/phone_auth_screen';

  static String activityCheckCandiScreen = '/activity_check_candi_screen';

  static String identityAuthenticationFailScreen =
      '/identity_authentication_fail_screen';

  static String voteCheck2Screen = '/vote_check2_screen';

  static String homeScreen = '/home_screen';
  static String revoteSuccessScreen = '/revote_success_screen';
  static String activityCheckRevote = '/activity_check_revote';
  static String identityAuthenticationScreen =
      '/identity_authentication_screen';

  static String appNavigationScreen = '/app_navigation_screen';

  static String initialRoute = '/initialRoute';

  static String resultScreen = '/result_screen';

  static String gotoResultScreen = '/goto_result_screen';

  static String homePage2='/home_page_after_login_screen';



  static List<GetPage> pages = [
    GetPage(
      name: gotoResultScreen,
      page: () => GotoResultScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic,votefor: dynamic),
      bindings: [
        GotoResultBinding(),
      ],
    ),
    GetPage(
      name: voteListScreen,
      page: () => VoteListScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic),
      bindings: [
        VoteListBinding(),
      ],
    ),
    GetPage(
      name: appKeyScreen,
      page: () => AppKeyScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic),
      bindings: [
        AppKeyBinding(),
      ],
    ),
    GetPage(
      name: appKeySuccessScreen,
      page: () => AppKeySuccessScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic),
      bindings: [
        AppKeySuccessBinding(),
      ],
    ),
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashScreenBinding(),
      ],
    ),
    GetPage(
      name: circularScreen,
      page: () => CircularScreen(),
      bindings: [
        CircularScreenBinding(),
      ],
    ),
    GetPage(
      name: identityAuthenticationSuccessScreen,
      page: () => IdentityAuthenticationSuccessScreen(),
      bindings: [
        IdentityAuthenticationSuccessBinding(),
      ],
    ),
    GetPage(
      name: voteSuccessScreen,
      page: () => VoteSuccessScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic,votefor: dynamic),
      bindings: [
        VoteSuccessBinding(),
      ],
    ),
    GetPage(
      name: revoteSuccessScreen,
      page: () => RevoteSuccessScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic,votefor: dynamic),
      bindings: [
        RevoteSuccessBinding(),
      ],
    ),
    GetPage(
      name: menuScreen,
      page: () => MenuScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic),
      bindings: [
        MenuBinding(),
      ],
    ),
    GetPage(
      name: activeInfoScreen,
      page: () => ActiveInfoScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic,num: dynamic),
      bindings: [
        ActiveInfoBinding(),
      ],
    ),
    GetPage(
      name: activityCheckCandiScreen,
      page: () => ActivityCheckCandiScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic,num:dynamic),
      bindings: [
        ActivityCheckCandiBinding(),
      ],
    ),
    // GetPage(
    //   name:homePage2,
    //   page: () => HomePageAfterLoginScreen(thisconnector:"",session:""),
    //   bindings: [
    //     HomePageAfterLoginBinding(),
    //   ],
    // ),

    GetPage(
      name: identityAuthenticationFailScreen,
      page: () => IdentityAuthenticationFailScreen(),
      bindings: [
        IdentityAuthenticationFailBinding(),
      ],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic,votefor: dynamic),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: identityAuthenticationScreen,
      page: () => IdentityAuthenticationScreen(),
      bindings: [
        IdentityAuthenticationBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: resultScreen,
      page: () => ResultScreen(),
      bindings: [
        ResultBinding(),
      ],
    ),
    GetPage(
      name: activityCheckRevote,
      page: () => ActivityCheckRevote(connector: dynamic,session:dynamic,uri:dynamic,flag:dynamic,num: dynamic),
      bindings: [
        ActivityCheckRevoteBinding(),
      ],
    ),
    GetPage(
      name: connectMetamaskScreen,
      page: () => MetamaskScreen(),
      bindings: [
        connectMetamaskBinding(),
      ],
    ),
    GetPage(
      name: phoneAuthScreen,
      page: () => PhoneAuthScreen(),

    )
  ];
}