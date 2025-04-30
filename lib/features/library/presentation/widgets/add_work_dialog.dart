import 'package:animated_visibility/animated_visibility.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/data/remote/work_service_registry.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';

class AddWorkDialog extends ConsumerStatefulWidget {
  const AddWorkDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddWorkDialogState();
}

class _AddWorkDialogState extends ConsumerState<AddWorkDialog> {
  bool _isLoading = false;
  final TextEditingController _urlController = TextEditingController();
  String? _subtitle;
  String? _errorText;
  double? _progress;

  void _setProgress({int? progress, int? total, String? message}) {
    if (progress != null && total != null) {
      setState(() {
        _progress = progress / total;
      });
    }
    if (message != null) {
      setState(() {
        _subtitle = message;
      });
    }
  }

  Future<bool> _addWorkFromUrl(String url) async {
    // Implement the logic to add work from the provided URL
    // This could involve fetching data from the URL and saving it to the database
    // Wait 5 seconds
    setState(() {
      _isLoading = true;
      _errorText = null;
      _progress = null;
    });

    final worksRepository = ref.read(worksRepositoryProvider);
    final workServiceRegistry = ref.read(workServiceRegistryProvider);
    final workService = workServiceRegistry.getServiceByURL(url);
    final dataStoragePrefs = ref.read(dataStoragePreferencesProvider);
    if (workService == null) {
      setState(() {
        _isLoading = false;
        _errorText = 'No work service found for the provided URL.';
      });
      return false;
    }

    try {
      final work = await workService.downloadWork(
        url,
        onProgress: _setProgress,
      );
      setState(() {
        _isLoading = false;
        _progress = null;
      });

      if (work == null) {
        setState(() {
          _errorText = 'Failed to download work from the provided URL.';
        });
        return false;
      }
      // Save the work to the database
      await worksRepository.upsertWork(work);
      return true;
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorText = 'An error occurred while adding the work: $e';
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Work from URL'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            Text('Enter the URL of the work you want to add:'),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Work URL',
                hintText: 'https://example.com/work-url',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              enabled: !_isLoading,
              onChanged: (_) {
                // Clear error when user types
                if (_errorText != null) {
                  setState(() {
                    _errorText = null;
                  });
                }
              },
              onSubmitted: (_) {
                if (!_isLoading) {
                  _addWorkFromUrl(_urlController.text).then((success) {
                    if (context.mounted && success) {
                      Navigator.of(context).pop();
                    }
                  });
                }
              },
            ),
            AnimatedVisibility(
              visible: _isLoading,
              enter: fadeIn(curve: kAnimationCurve),
              enterDuration: kAnimationDuration,
              exit: fadeOut(curve: kAnimationCurve),
              exitDuration: kAnimationDuration,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.0,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: context.scheme.outlineVariant,
                      ),
                    ),
                    Text(
                      'Adding work...',
                      style: context.text.bodyMedium?.copyWith(
                        color: context.scheme.onSurface,
                      ),
                    ),
                    if (_subtitle.isNotNullOrBlank)
                      Text(
                        _subtitle!,
                        style: context.text.bodySmall?.copyWith(
                          color: context.scheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed:
              _isLoading
                  ? null
                  : () async {
                    bool success = await _addWorkFromUrl(_urlController.text);
                    if (context.mounted && success) {
                      Navigator.of(context).pop();
                    } else if (context.mounted) {
                      if (_errorText.isNotNullOrBlank) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_errorText!),
                            duration: const Duration(seconds: 3),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to add work from URL.'),
                            duration: Duration(seconds: 3),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
          child: const Text('Add Work'),
        ),
      ],
    );
  }
}
