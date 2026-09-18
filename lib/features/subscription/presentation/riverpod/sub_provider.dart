import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/subscription/presentation/riverpod/sub_notifier.dart';
import 'package:pet_care/features/subscription/presentation/riverpod/sub_state.dart';

final subProvider = NotifierProvider<SubNotifier, SubState>(SubNotifier.new);
