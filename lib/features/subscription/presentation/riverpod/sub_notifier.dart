import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/subscription/presentation/riverpod/sub_state.dart';

class SubNotifier extends Notifier<SubState> {
  @override
  SubState build() {
    return const SubState(success: false, failed: false, loading: 'idle');
  }
}
