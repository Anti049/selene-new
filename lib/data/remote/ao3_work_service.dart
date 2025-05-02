import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:selene/core/database/models/author.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/fandom.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/data/remote/i_work_service.dart';
import 'package:string_stats/string_stats.dart';

class AO3WorkService extends IWorkService {
  // Constructor
  AO3WorkService({
    required super.logger,
    required super.fileServiceRegistry,
    required super.dataStoragePrefs,
    super.email = '',
    super.password = '',
    super.dioClient,
  }) : super(
         serviceID: 'ao3',
         serviceName: 'Archive of Our Own',
         serviceIcon: 'assets/icons/ao3.svg',
         siteDomain: 'archiveofourown.org',
         acceptedDomains: [
           'archiveofourown.org',
           'archiveofourown.com',
           'archiveofourown.next',
           'download.archiveofourown.org',
           'download.archiveofourown.com',
           'download.archiveofourown.next',
           'ao3.org',
         ],
         validPatterns: [
           'https://archiveofourown.org/token_dispenser.json',
           'https://archiveofourown.org/users/login',
           'https://archiveofourown.org/works/\\d+',
           'https://archiveofourown.org/works/(\\d+)/navigate\\?.+',
           'https://archiveofourown.org/works/(\\d+)/chapters/\\d+',
           'https://archiveofourown.org/series/\\d+',
           'https://archiveofourown.org/collections/\\d+',
           'https://archiveofourown.org/users/[^/]+/bookmarks',
           'https://archiveofourown.org/users/[^/]+/bookmarks\\?page=\\d+',
           'https://archiveofourown.org/users/[^/]+/subscriptions',
           'https://archiveofourown.org/users/[^/]+/subscriptions\\?page=\\d+',
           'https://archiveofourown.org/users/[^/]+/works',
           'https://archiveofourown.org/users/[^/]+/works\\?page=\\d+',
           'https://archiveofourown.org/users/[^/]+/series',
           'https://archiveofourown.org/users/[^/]+/series\\?page=\\d+',
           'https://archiveofourown.org/users/[^/]+/collections',
           'https://archiveofourown.org/users/[^/]+/collections\\?page=\\d+',
           'https://archiveofourown.org/users/[^/]+/history',
           'https://archiveofourown.org/users/[^/]+/history\\?page=\\d+',
         ],
         exampleURLs: [
           'https://archiveofourown.org/works/123456',
           'https://archiveofourown.org/works/123456/chapters/789012',
           'https://archiveofourown.org/series/123456',
           'https://archiveofourown.org/collections/123456',
           'https://archiveofourown.org/users/username/bookmarks',
           'https://archiveofourown.org/users/username/bookmarks?page=1',
           'https://archiveofourown.org/users/username/subscriptions',
           'https://archiveofourown.org/users/username/works',
           'https://archiveofourown.org/users/username/series',
           'https://archiveofourown.org/users/username/collections',
           'https://archiveofourown.org/users/username/history',
         ],
         hasAdultWorks: true,
       ) {
    dio.options.baseUrl = 'https://$siteDomain';
    dio.options.headers['User-Agent'] = 'Selene/1.0 (https://selene.app)';
    // Add "view_adult" cookie if hasAdultWorks is true
    if (hasAdultWorks) {
      dio.options.headers['Cookie'] = 'view_adult=true';
    }
  }

  // Methods
  @override
  Future<WorkModel?> downloadWork(
    String sourceURL, {
    Function({int? progress, int? total, String? message})? onProgress,
  }) async {
    onProgress?.call(message: 'Fetching work metadata...');
    // Remove everything after the work ID
    // All we should be left with is the base work URL
    // For example, if the sourceURL is:
    // https://archiveofourown.org/works/123456/chapters/789012
    // We want to extract https://archiveofourown.org/works/123456
    sourceURL = sourceURL.replaceFirst('http://', 'https://');
    sourceURL = sourceURL.trim().replaceAll(RegExp(r'/chapters/\d+'), '');
    sourceURL = sourceURL.replaceAll(RegExp(r'/navigate\?.+'), '');
    final workIdPattern = r'https://archiveofourown.org/works/(\d+)';
    final match = RegExp(workIdPattern).firstMatch(sourceURL);
    if (match == null) {
      throw Exception('Invalid work URL: $sourceURL');
    }
    final workId = match.group(1);
    final siteDomain = 'archiveofourown.org';
    final workURL = 'https://$siteDomain/works/$workId';
    // Get metadata URL
    final metadataURL = workURL + (hasAdultWorks ? '?view_adult=true' : '');
    // Get Chapter Index URL
    final chaptersURL =
        '$workURL/navigate${hasAdultWorks ? '?view_adult=true' : ''}';

    // Get metadata body
    final metaResponse = await dio.get(
      metadataURL,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          onProgress?.call(
            progress: received,
            total: total,
            message: 'Fetching work metadata...',
          );
        }
      },
    );
    if (metaResponse.statusCode != 200) {
      throw Exception(
        'Failed to fetch work metadata: ${metaResponse.statusMessage}',
      );
    }
    final metaSoup = BeautifulSoup(metaResponse.data.toString());
    onProgress?.call(message: 'Parsing work metadata...');

    // Get basic metadata
    try {
      // Title
      final title = metaSoup.find('h2', class_: 'title')!.text.trim();

      // Author(s)
      // h3 class="byline" -> a rel="author"
      final authorLinks =
          metaSoup
              .find('h3', class_: 'byline')
              ?.findAll('a', attrs: {'rel': 'author'}) ??
          [];
      final authors =
          authorLinks.map((a) {
            final username = a.text.trim();
            final userURL = a.attributes['href'] ?? '';
            return AuthorModel(
              name: username,
              sourceURL: 'https://$siteDomain$userURL',
            );
          }).toList();

      // Summary
      // div class="summary" -> blockquote
      // Save summary as HTML
      final summaryElement = metaSoup
          .find('div', class_: 'summary')
          ?.find('blockquote');
      final summary = summaryElement!.innerHtml.trim();

      // Fandom(s)
      // dd class="fandoms" -> ul -> li -> a
      final fandomLinks =
          metaSoup
              .find('dd', class_: 'fandom')
              ?.findAll('ul')
              .expand((ul) => ul.findAll('li').map((li) => li.find('a')))
              .toList();
      final fandoms =
          fandomLinks?.map((a) {
            final fandomName = a!.text.trim();
            final fandomURL =
                a.attributes.containsKey('href')
                    ? 'https://$siteDomain${a.attributes['href']}'
                    : '';
            return FandomModel(name: fandomName, sourceURLs: [fandomURL]);
          }).toList() ??
          [];

      // Tag(s)
      // dd class="tags" -> ul -> li -> a
      // Multiple separate dds for different tag types
      final tagElements = metaSoup.findAll('dd', class_: 'tags');
      final tags = <TagModel>[];
      for (final tagElement in tagElements) {
        final tagClass = tagElement.attributes['class'] ?? '';
        final tagLinks =
            tagElement.findAll('ul').expand((ul) {
              return ul.findAll('li').map((li) => li.find('a'));
            }).toList();
        for (final a in tagLinks) {
          final tagName = a!.text.trim();
          final tagURL =
              a.attributes.containsKey('href')
                  ? 'https://$siteDomain${a.attributes['href']}'
                  : '';
          // Does the dd class contain "relationship"?
          TagType tagType = TagType.freeform;
          if (tagClass.contains('relationship')) {
            // Additional processing needed
            tagType =
                tagName.contains('/') ? TagType.romance : TagType.friendship;
          } else if (tagClass.contains('character')) {
            tagType = TagType.character;
          }

          final tag = TagModel(name: tagName, sourceURL: tagURL, type: tagType);
          tags.add(tag);
        }
      }

      // Published Date
      // dd class="published"
      final publishedElement = metaSoup.find('dd', class_: 'published');
      final publishedString = publishedElement?.text.trim() ?? 'Unknown Date';
      final publishedDate =
          DateTime.tryParse(publishedString) ?? DateTime.now();

      // Updated/Completed Date
      // dt class="status" contains "Updated" or "Completed"
      // dd class="status" contains the date
      WorkStatus status = WorkStatus.unknown;
      final statusElement = metaSoup.find('dt', class_: 'status');
      DateTime? updatedDate;
      if (statusElement != null) {
        final statusText = statusElement.text.trim();
        if (statusText.contains('Updated')) {
          status = WorkStatus.inProgress;
        } else if (statusText.contains('Completed')) {
          status = WorkStatus.completed;
        }
      }
      final statusDateElement = metaSoup.find('dd', class_: 'status');
      if (statusDateElement != null) {
        final statusDateString = statusDateElement.text.trim();
        updatedDate = DateTime.tryParse(statusDateString) ?? DateTime.now();
      }

      // Word count
      // dd class="words" -> text
      final wordCountElement = metaSoup.find('dd', class_: 'words');
      final wordCountString = wordCountElement?.text.trim() ?? 'Unknown Words';
      final wordCount = int.tryParse(wordCountString.replaceAll(',', '')) ?? 0;

      // Chapters
      final chapterIndexResponse = await dio.get(chaptersURL);
      if (chapterIndexResponse.statusCode != 200) {
        throw Exception(
          'Failed to fetch work chapters: ${chapterIndexResponse.statusMessage}',
        );
      }
      final chapterIndexSoup = BeautifulSoup(
        chapterIndexResponse.data.toString(),
      );
      // Iterate over chapters in ordered list and get name, number, and date posted
      // ol class="chapter index group" -> li -> a (contains chapter name and URL)
      // ol class="chapter index group" -> li -> span (contains date posted)
      final chapterElements = chapterIndexSoup.findAll(
        'ol',
        class_: 'chapter index group',
      );
      final chapters = <ChapterModel>[];
      for (final chapterElement in chapterElements) {
        final chapterItems = chapterElement.findAll('li');
        for (final chapterItem in chapterItems) {
          final chapterLink = chapterItem.find('a');
          final chapterName =
              chapterLink?.text.substring(chapterLink.text.indexOf('. ') + 2) ??
              'Untitled Chapter';
          final chapterURL = chapterLink?.attributes['href'] ?? '';
          final chapterDateElement = chapterItem.find('span');
          final chapterDateString =
              chapterDateElement?.text.trim() ?? 'Unknown Date';
          final chapterDate =
              DateTime.tryParse(chapterDateString) ?? DateTime.now();

          final chapter = ChapterModel(
            index: chapters.length + 1, // Incremental chapter number
            title: chapterName,
            sourceURL: 'https://$siteDomain$chapterURL',
            datePublished: chapterDate,
          );
          chapters.add(chapter);
        }
      }

      final loadedChapters = <ChapterModel>[];
      onProgress?.call(
        progress: 0,
        total: chapters.length,
        message: 'Downloading chapters...',
      );
      // Download each chapter content
      for (final chapter in chapters) {
        // Set progress
        onProgress?.call(
          progress: loadedChapters.length + 1,
          total: chapters.length,
          message: 'Downloading chapter ${chapter.index}...',
        );
        // Update chapter content
        final loadedChapter = await downloadChapter(chapter);
        if (loadedChapter == null) {
          logger.w(
            'Failed to download chapter ${chapter.index} (${chapter.title})',
          );
          continue;
        }
        loadedChapters.add(loadedChapter);
        // Add delay to avoid overwhelming the server
        final delaySeconds = dataStoragePrefs.downloadDelaySeconds.get();
        if (delaySeconds > 0) {
          await Future.delayed(Duration(seconds: delaySeconds));
        }
      }
      // Replace chapters by source URL
      for (final loadedChapter in loadedChapters) {
        final index = chapters.indexWhere(
          (c) => c.sourceURL == loadedChapter.sourceURL,
        );
        if (index != -1) {
          chapters[index] = loadedChapter;
        } else {
          logger.w(
            'Loaded chapter ${loadedChapter.index} (${loadedChapter.title}) not found in original chapters.',
          );
        }
      }
      onProgress?.call(
        progress: chapters.length,
        total: chapters.length,
        message: 'All chapters downloaded.',
      );

      // Return compiled work
      final work = WorkModel(
        title: title,
        sourceURL: sourceURL,
        summary: summary,
        fandoms: fandoms,
        authors: authors,
        tags: tags,
        datePublished: publishedDate,
        dateUpdated: updatedDate,
        status: status,
        wordCount: wordCount,
        chapters: chapters,
      );

      // Save to file
      final savePath = determineSavePath(work.title, workId!);
      final epubFileService = fileServiceRegistry.getServiceByExtension(
        '.epub',
      );
      if (epubFileService == null) {
        logger.e('No EPUB file service found for saving work.');
        return work; // Return work without saving
      }
      try {
        final filePath = await epubFileService.saveFile(work, savePath);
        if (filePath.isEmpty) {
          logger.e('Failed to save work to file: $savePath');
          return work; // Return work without file path
        }

        logger.i('Work saved to file: $filePath');
        onProgress?.call(message: 'Work saved to file: $filePath');
        return work.copyWith(filePath: filePath);
      } catch (e) {
        logger.e('Error saving work to file: $e');
        rethrow;
      }
    } catch (e) {
      logger.e('Error parsing work metadata: $e');
      rethrow;
    }
  }

  @override
  Future<ChapterModel?> downloadChapter(
    ChapterModel source, {
    Function({int? progress, int? total, String? message})? onProgress,
  }) async {
    final chapterURL = source.sourceURL;
    if (chapterURL == null || chapterURL.isEmpty) {
      logger.e('Chapter URL is empty. Cannot download chapter.');
      return null;
    }
    final chapterResponse = await dio.get(chapterURL);
    if (chapterResponse.statusCode != 200) {
      logger.e(
        'Failed to fetch chapter content: ${chapterResponse.statusMessage}',
      );
      return null;
    }
    final chapterSoup = BeautifulSoup(chapterResponse.data.toString());

    // Summary
    // div class="summary" -> blockquote
    final summaryElement = chapterSoup
        .find('div', class_: 'summary')
        ?.find('blockquote');
    final summary = summaryElement?.innerHtml.trim() ?? '';
    final summaryText = summaryElement?.text.trim() ?? '';

    // Content
    // div class="userstuff"
    // Exclude h3 class="landmark"
    final contentElement = chapterSoup.find('div', class_: 'userstuff');
    if (contentElement == null) {
      logger.e('Chapter content not found.');
      return null;
    }
    // Remove landmark headings (h3) from content
    // Bs4Element does not have a "remove" member function
    for (final child in contentElement.children) {
      if (child.className.contains('landmark')) {
        // Remove the landmark heading from the content
        child.extract();
      }
    }
    final content = contentElement.innerHtml.trim();
    final contentText = contentElement.text.trim();

    // Start Notes
    // div class="notes module" -> blockquote
    // do NOT grab the "end notes" module
    final startNotesElement = chapterSoup
        .find('div', class_: 'notes module')
        ?.find('blockquote');
    final startNotes = startNotesElement?.innerHtml.trim() ?? '';
    final startNotesText = startNotesElement?.text.trim() ?? '';

    // End Notes
    // div class="end notes module" -> blockquote
    final endNotesElement = chapterSoup
        .find('div', class_: 'end notes module')
        ?.find('blockquote');
    final endNotes = endNotesElement?.innerHtml.trim() ?? '';
    final endNotesText = endNotesElement?.text.trim() ?? '';

    // Word Count
    // Word count is calculated from the plain text content + both notes + summary
    final wordCount =
        WordCounter.fromString(
          '$summaryText $contentText $startNotesText $endNotesText',
        ).count;

    // Return the chapter with updated content
    return source.copyWith(
      content: content,
      summary: summary,
      startNotes: startNotes,
      endNotes: endNotes,
      wordCount: wordCount,
    );
  }

  @override
  Future<bool> requiresAdult(String sourceURL, {Response? response}) async {
    // Implement the logic to check if the work requires adult content
    // This is a placeholder implementation
    throw UnimplementedError('AO3WorkService.requiresAdult not implemented');
  }

  @override
  Future<bool> requiresLogin(String sourceURL, {Response? response}) async {
    // Implement the logic to check if the work requires login
    // This is a placeholder implementation
    throw UnimplementedError('AO3WorkService.requiresLogin not implemented');
  }

  @override
  Future<bool> tryLogin() async {
    // Implement the logic to attempt login to AO3
    // This is a placeholder implementation
    throw UnimplementedError('AO3WorkService.tryLogin not implemented');
  }
}
