import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/provider/common.dart';

final noteControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final note = ref.watch(transactionNoteProvider);
  final controller = TextEditingController(text: note);
  
  // Keep controller and state in sync
  controller.addListener(() {
    ref.read(transactionNoteProvider.notifier).state = controller.text;
  });

  return controller;
});
