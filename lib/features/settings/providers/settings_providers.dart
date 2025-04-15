import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';
import 'package:selene/features/settings/screens/appearance/providers/appearance_preferences.dart';

part 'settings_providers.g.dart';

// Search query provider
@riverpod
class SettingsSearchQuery extends _$SettingsSearchQuery {
  @override
  String build() {
    return '';
  }

  void setQuery(String query) {
    state = query;
  }
}

// All settings provider
@riverpod
List<SearchableSettingItem> allSettings(Ref ref) {
  return [...ref.watch(appearanceSettingsProvider)];
}

// Filtered settings provider
@riverpod
List<SearchableSettingItem> filteredSettings(Ref ref) {
  final query = ref.watch(settingsSearchQueryProvider).toLowerCase();
  final allSettings = getAllSettings(ref.watch(allSettingsProvider));

  if (query.isEmpty) {
    return allSettings;
  }

  return allSettings.where((setting) {
    return setting.matchesQuery(query);
  }).toList();
}

extension SearchableSettingItemExtension on SearchableSettingItem {
  bool matchesQuery(String query) {
    if (label.toLowerCase().contains(query)) return true;
    if (subtitle?.toLowerCase().contains(query) ?? false) return true;
    if (keywords.any((keyword) => keyword.toLowerCase().contains(query))) {
      return true;
    }
    if (breadcrumbs.any(
      (breadcrumb) => breadcrumb.toLowerCase().contains(query),
    )) {
      return true;
    }
    return false;
  }
}

// Iterates over setting and its children, if it has any, and returns a list of all settings that are NOT groups (but DOES return a group's children)
List<SearchableSettingItem> getAllSettings(
  List<SearchableSettingItem> settings,
) {
  final allSettings = <SearchableSettingItem>[];
  for (final setting in settings) {
    if (setting.type != SettingType.groupSetting) {
      allSettings.add(setting);
    } else {
      allSettings.addAll(getAllSettings(setting.children ?? []));
    }
  }
  return allSettings;
}
