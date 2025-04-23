import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/library_providers.dart';

part 'work_details_provider.g.dart';

@riverpod
Future<WorkModel?> workDetails(Ref ref, int workID) async {
  final worksRepository = ref.watch(worksRepositoryProvider);
  return worksRepository.getWorkByID(workID);
}
