
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/subscription/riverpod/sub_notifier.dart';
import 'package:pet_care/features/subscription/riverpod/sub_state.dart';

final subProvider = NotifierProvider<SubNotifier,SubState>(SubNotifier.new);