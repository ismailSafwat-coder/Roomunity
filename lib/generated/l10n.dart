// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `welcome 3368`
  String get welcome {
    return Intl.message('welcome 3368', name: 'welcome', desc: '', args: []);
  }

  /// `Where will you travel?`
  String get travel {
    return Intl.message(
      'Where will you travel?',
      name: 'travel',
      desc: '',
      args: [],
    );
  }

  /// `Kingdom Center · Riyadh`
  String get location {
    return Intl.message(
      'Kingdom Center · Riyadh',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `studey Rings`
  String get studeyRings {
    return Intl.message(
      'studey Rings',
      name: 'studeyRings',
      desc: '',
      args: [],
    );
  }

  /// `King Saud University`
  String get king_saud_university {
    return Intl.message(
      'King Saud University',
      name: 'king_saud_university',
      desc: '',
      args: [],
    );
  }

  /// `King Abdulaziz University`
  String get king_abdulaziz_university {
    return Intl.message(
      'King Abdulaziz University',
      name: 'king_abdulaziz_university',
      desc: '',
      args: [],
    );
  }

  /// `King Fahd University`
  String get king_fahd_university {
    return Intl.message(
      'King Fahd University',
      name: 'king_fahd_university',
      desc: '',
      args: [],
    );
  }

  /// `Cars`
  String get cars {
    return Intl.message('Cars', name: 'cars', desc: '', args: []);
  }

  /// `Books and Notes`
  String get books_and_notes {
    return Intl.message(
      'Books and Notes',
      name: 'books_and_notes',
      desc: '',
      args: [],
    );
  }

  /// `Child Care`
  String get child_care {
    return Intl.message('Child Care', name: 'child_care', desc: '', args: []);
  }

  /// `Hospital Assistance`
  String get hospital_assistance {
    return Intl.message(
      'Hospital Assistance',
      name: 'hospital_assistance',
      desc: '',
      args: [],
    );
  }

  /// `Football`
  String get football {
    return Intl.message('Football', name: 'football', desc: '', args: []);
  }

  /// `PUBG`
  String get pubg {
    return Intl.message('PUBG', name: 'pubg', desc: '', args: []);
  }

  /// `Baloot`
  String get baloot {
    return Intl.message('Baloot', name: 'baloot', desc: '', args: []);
  }

  /// `Walkway`
  String get walkway {
    return Intl.message('Walkway', name: 'walkway', desc: '', args: []);
  }

  /// `Chess`
  String get chess {
    return Intl.message('Chess', name: 'chess', desc: '', args: []);
  }

  /// `services`
  String get services {
    return Intl.message('services', name: 'services', desc: '', args: []);
  }

  /// `Councils`
  String get Councils {
    return Intl.message('Councils', name: 'Councils', desc: '', args: []);
  }

  /// `You need to log in to access this page.`
  String get login_required_message {
    return Intl.message(
      'You need to log in to access this page.',
      name: 'login_required_message',
      desc: '',
      args: [],
    );
  }

  /// `Login now`
  String get login_now {
    return Intl.message('Login now', name: 'login_now', desc: '', args: []);
  }

  /// `View Profile`
  String get view_profile {
    return Intl.message(
      'View Profile',
      name: 'view_profile',
      desc: '',
      args: [],
    );
  }

  /// `Wallet record`
  String get wallet_record {
    return Intl.message(
      'Wallet record',
      name: 'wallet_record',
      desc: '',
      args: [],
    );
  }

  /// `Rate us`
  String get rate_us {
    return Intl.message('Rate us', name: 'rate_us', desc: '', args: []);
  }

  /// `Host with us (Add Property)`
  String get host_with_us {
    return Intl.message(
      'Host with us (Add Property)',
      name: 'host_with_us',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods`
  String get payment_methods {
    return Intl.message(
      'Payment methods',
      name: 'payment_methods',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message('Contact Us', name: 'contact_us', desc: '', args: []);
  }

  /// `Invite Friends`
  String get invite_friends {
    return Intl.message(
      'Invite Friends',
      name: 'invite_friends',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message('FAQ', name: 'faq', desc: '', args: []);
  }

  /// `Terms of use`
  String get terms_of_use {
    return Intl.message(
      'Terms of use',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Welcome to Roomunity`
  String get welcome_to_roomunity {
    return Intl.message(
      'Welcome to Roomunity',
      name: 'welcome_to_roomunity',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get sign_in_to_continue {
    return Intl.message(
      'Sign in to continue',
      name: 'sign_in_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Login with`
  String get login_with {
    return Intl.message('Login with', name: 'login_with', desc: '', args: []);
  }

  /// `By continuing you agree to our Terms & Conditions`
  String get by_continuing {
    return Intl.message(
      'By continuing you agree to our Terms & Conditions',
      name: 'by_continuing',
      desc: '',
      args: [],
    );
  }

  /// `Join as guest`
  String get join_as_guest {
    return Intl.message(
      'Join as guest',
      name: 'join_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `User not logged in`
  String get user_not_logged {
    return Intl.message(
      'User not logged in',
      name: 'user_not_logged',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save user data`
  String get failed_save_user_data {
    return Intl.message(
      'Failed to save user data',
      name: 'failed_save_user_data',
      desc: '',
      args: [],
    );
  }

  /// `Tell Us About You`
  String get tell_us_about_you {
    return Intl.message(
      'Tell Us About You',
      name: 'tell_us_about_you',
      desc: '',
      args: [],
    );
  }

  /// `Fill in your info to continue.`
  String get fill_info_to_continue {
    return Intl.message(
      'Fill in your info to continue.',
      name: 'fill_info_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Enter your first name`
  String get enter_first_name {
    return Intl.message(
      'Enter your first name',
      name: 'enter_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Enter your last name`
  String get enter_last_name {
    return Intl.message(
      'Enter your last name',
      name: 'enter_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Select Gender`
  String get select_gender {
    return Intl.message(
      'Select Gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Please select your gender`
  String get please_select_gender {
    return Intl.message(
      'Please select your gender',
      name: 'please_select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get enter_valid_email {
    return Intl.message(
      'Enter a valid email',
      name: 'enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number`
  String get enter_valid_number {
    return Intl.message(
      'Enter a valid number',
      name: 'enter_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueT {
    return Intl.message('Continue', name: 'continueT', desc: '', args: []);
  }

  /// `change language`
  String get change_language {
    return Intl.message(
      'change language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `welcom to you in `
  String get welcom_to_you {
    return Intl.message(
      'welcom to you in ',
      name: 'welcom_to_you',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
