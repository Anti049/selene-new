import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/data/local/i_file_service.dart';

class EpubFileService extends IFileService {
  // Constructor
  EpubFileService({required super.logger, required super.dataStoragePrefs})
    : super(serviceID: 'epub', acceptedExtensions: ['.epub']);

  // Methods
  @override
  Future<String> saveFile(WorkModel work, String filePath) async {
    // Create book
    EpubBook book = EpubBook();

    // Populate metadata
    book.Title = work.title;
    book.AuthorList = work.authors.map((author) => author.name).toList();

    // Create content files
    book.Content = EpubContent();
    book.Content!.Html = {};

    // Add title page
    EpubTextContentFile titlePageFile =
        EpubTextContentFile()
          ..FileName = 'title_page.xhtml'
          ..Content = _generateTitlePageHtml(work)
          ..ContentMimeType = 'application/xhtml+xml'
          ..ContentType = EpubContentType.XHTML_1_1;
    book.Content!.Html![titlePageFile.FileName!] = titlePageFile;

    // Add info page
    EpubTextContentFile infoPageFile =
        EpubTextContentFile()
          ..FileName = 'info_page.xhtml'
          ..Content = _generateInfoPageHtml(work)
          ..ContentMimeType = 'application/xhtml+xml'
          ..ContentType = EpubContentType.XHTML_1_1;
    book.Content!.Html![infoPageFile.FileName!] = infoPageFile;

    // Add chapters
    int chapterIndex = 1;
    for (var chapter in work.chapters) {
      String chapterFullIndex = chapterIndex.toString().padLeft(3, '0');

      // Build file
      EpubTextContentFile chapterFile =
          EpubTextContentFile()
            ..FileName = 'chapter_$chapterFullIndex.xhtml'
            ..Content = chapter.createContent()
            ..ContentMimeType = 'application/xhtml+xml'
            ..ContentType = EpubContentType.XHTML_1_1;

      book.Content!.Html![chapterFile.FileName!] = chapterFile;
      chapterIndex++;
    }

    // Define chapter structure
    book.Chapters = [];
    for (var chapter in work.chapters) {
      final chapterRef =
          EpubChapter()
            ..Title = chapter.title
            ..ContentFileName =
                'chapter_${chapterIndex.toString().padLeft(3, '0')}.xhtml';
      book.Chapters!.add(chapterRef);
      chapterIndex++;
    }

    // Add title page
    book.Chapters!.insert(
      0,
      EpubChapter()
        ..Title = 'Title Page'
        ..ContentFileName = titlePageFile.FileName!,
    );

    // Add info page
    book.Chapters!.insert(
      1,
      EpubChapter()
        ..Title = 'Information'
        ..ContentFileName = infoPageFile.FileName!,
    );

    // Write to EPUB file
    final epubData = EpubWriter.writeBook(book);
    if (epubData == null) {
      throw Exception('Failed to write EPUB book');
    }

    // Save the EPUB data to the specified file path
    final file = File(filePath);
    await file.create(recursive: true); // Ensure the directory exists
    final result = await file.writeAsBytes(epubData);
    if (!(await result.exists())) {
      throw Exception('Failed to save EPUB book to $filePath');
    }

    return filePath;
  }

  @override
  Future<WorkModel?> loadFile(String filePath) async {
    try {
      // Does file exist?
      final file = File(filePath);
      if (!await file.exists()) {
        logger.e('EPUB file does not exist at $filePath');
        return null; // Return null if file does not exist
      }

      // Read the EPUB file
      final epubData = await file.readAsBytes();
      if (epubData.isEmpty) {
        logger.e('EPUB file is empty at $filePath');
        return null; // Return null if file is empty
      }

      // Parse the EPUB data
      final epubBook = await EpubReader.readBook(epubData);

      // Extract metadata
      final workTitle = epubBook.Title ?? 'Untitled';

      // Create WorkModel from EPUB data
      // final work = WorkModel(
      //   title: epubBook.Title ?? 'Untitled',
      //   authors:
      //       (epubBook.AuthorList ?? [])
      //           .map((name) => AuthorModel(name: name))
      //           .toList(),
      //   chapters: [], // Populate chapters later
      //   fandoms: [], // Populate fandoms if available
      //   tags: [], // Populate tags if available
      //   summary: epubBook.Description,
      //   status: WorkStatusModel(label: 'Unknown'), // Set default status
      //   datePublished:
      //       epubBook.PublishDate != null
      //           ? DateTime.parse(epubBook.PublishDate!)
      //           : null,
      //   dateUpdated:
      //       epubBook.ModificationDate != null
      //           ? DateTime.parse(epubBook.ModificationDate!)
      //           : null,
      // );
    } catch (e) {
      logger.e('Failed to load EPUB file: $e');
      return null; // Return null if loading fails
    }
  }

  @override
  Future<List<WorkModel>> loadAllFiles(String directoryPath) async {
    // Get all files inside directory that have an extension in acceptedExtensions
    final dir = Directory(directoryPath);
    if (!(await dir.exists())) {
      throw Exception('Directory does not exist at $directoryPath');
    }

    final files = await dir.list().toList();

    final epubFiles =
        files
            .where(
              (file) =>
                  file is File &&
                  acceptedExtensions.contains(
                    '.${file.path.split('.').last.toLowerCase()}',
                  ),
            )
            .toList();

    if (epubFiles.isEmpty) {
      return [];
    }

    // Load each EPUB file and convert to WorkModel
    final workModels = <WorkModel>[];
    for (final file in epubFiles) {
      if (file is File) {
        final workModel = await loadFile(file.path);
        if (workModel != null) {
          workModels.add(workModel);
        }
      }
    }
    return workModels;
  }

  @override
  Future<bool> deleteFile(String filePath) async {
    // Implement the logic to delete the EPUB file
    // This is a placeholder implementation
    return true; // Return true if the file was deleted successfully
  }

  // Helper Methods
  String _generateTitlePageHtml(WorkModel work) {
    final authorNames = work.authors.map((a) => a.name).join(', ');
    // Basic centered title page HTML
    return '''
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Title Page</title>
    <style>
      body { text-align: center; margin-top: 20%; }
      h1 { font-size: 2em; }
      h2 { font-size: 1.2em; font-style: italic; }
    </style>
</head>
<body>
    <h1>${work.title}</h1>
    <h2>by</h2>
    <h2>$authorNames</h2>
</body>
</html>
  ''';
  }

  String _generateInfoPageHtml(WorkModel work) {
    // Build the info page HTML (adapt styling as needed)
    final summaryHtml =
        work.summary != null
            ? '<h2>Summary</h2><div>${work.summary}</div><hr/>'
            : '';
    final fandomsHtml =
        work.fandoms.isNotEmpty
            ? '<h2>Fandoms</h2><ul>${work.fandoms.map((f) => '<li>${f.name}</li>').join()}</ul><hr/>'
            : '';
    final tagsHtml =
        work.tags.isNotEmpty
            ? '<h2>Tags</h2><ul>${work.tags.map((t) => '<li>${t.name} (${t.type.name})</li>').join()}</ul><hr/>'
            : '';
    // Add more details as needed (status, word count, dates)
    final detailsHtml = '''
    <h2>Details</h2>
    <ul>
      <li>Status: ${work.status.label}</li>
      <li>Word Count: ${work.wordCount ?? 'N/A'}</li>
      <li>Published: ${work.datePublished?.toLocal().toIso8601String().split('T').first ?? 'N/A'}</li>
      <li>Updated: ${work.dateUpdated?.toLocal().toIso8601String().split('T').first ?? 'N/A'}</li>
    </ul>
  ''';

    return '''
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Information</title>
    </head>
<body>
    <h1>Work Information</h1>
    <hr/>
    $summaryHtml
    $fandomsHtml
    $tagsHtml
    $detailsHtml
</body>
</html>
  ''';
  }
}
