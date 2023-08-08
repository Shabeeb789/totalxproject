import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//email error provider//
final errorProvider = StateProvider<bool>((ref) {
  return true;
});
//hide password sign up
final hidepasswordsignupProvider = StateProvider<bool>((ref) {
  return true;
});

//hide password login  //

final hiddenpassworedsigninProvider = StateProvider<bool>((ref) {
  return false;
});
//password error provider//
final passwordErrorProvider = StateProvider<bool>((ref) {
  return true;
});

// signupemailprovider//

final emailProvider = StateProvider<bool>((ref) {
  return true;
});

// signuppasswordprovider//

final passwordProvider = StateProvider<bool>((ref) {
  return true;
});

//imagepickerprovider//
final imageProvider = StateProvider<File?>((ref) {
  return null;
});
