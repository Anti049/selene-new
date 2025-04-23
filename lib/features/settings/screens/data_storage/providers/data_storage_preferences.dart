import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/database/providers/preferences_stream_provider.dart';
import 'package:selene/core/utils/filesystem.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

part 'data_storage_preferences.g.dart';

class DataStoragePreferences {
  final Isar _isar;

  DataStoragePreferences(this._isar);

  late final Preference<String> libraryFolder = Preference<String>(
    isar: _isar,
    defaultValue: kDefaultLibraryFolder,
    getter: (prefs) => prefs.libraryFolder,
    setter: (prefs, value) => prefs.copyWith(libraryFolder: value),
  );

  late final Preference<List<String>> importFolders = Preference<List<String>>(
    isar: _isar,
    defaultValue: kDefaultImportFolders,
    getter: (prefs) => prefs.importFolders,
    setter: (prefs, value) => prefs.copyWith(importFolders: value),
  );
}

@riverpod
DataStoragePreferences dataStoragePreferences(Ref ref) {
  // Get Isar instance directly when available
  final isar = ref.watch(isarProvider).requireValue;
  // Watch the overall preferences stream to trigger rebuilds if any pref changes
  ref.watch(preferencesStreamProvider);
  // Pass the Isar instance to the class constructor
  return DataStoragePreferences(isar);
}

@riverpod
List<SearchableSettingItem> dataStorageSettings(Ref ref) {
  final route = '/settings/data_storage';
  final dataStoragePrefs = ref.watch(dataStoragePreferencesProvider);
  return [
    SearchableSettingItem.group(
      label: 'Data Storage',
      children: [
        SearchableSettingItem(
          label: 'Library Folder',
          subtitle: dataStoragePrefs.libraryFolder.get(),
          type: SettingType.buttonSetting,
          preference: dataStoragePrefs.libraryFolder,
          icon: Symbols.folder,
          route: route,
          onTapAction: (BuildContext context) async {
            final permission = await getPermission(context);
            var status = await permission.status;
            if (!status.isGranted) {
              status = await permission.request();
            }
            if (status.isGranted) {
              final result = await FilePicker.platform.getDirectoryPath();
              if (result != null) {
                dataStoragePrefs.libraryFolder.set(result);
              }
            }
          },
          breadcrumbs: ['Settings', 'Data Storage'],
          keywords: ['library', 'folder', 'storage'],
        ),
        // SearchableSettingItem(
        //   label: 'Import Folders',
        //   type: SettingType.multipleChoice,
        //   preference: dataStoragePrefs.importFolders,
        //   route: '$route/import_folders',
        // ),
      ],
    ),
  ];
}
