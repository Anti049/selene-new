import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:html_unescape/html_unescape.dart';
import 'package:mustache_template/mustache.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/data/local/i_file_service.dart';
import 'package:xml/xml.dart' as xml;

class EpubFileService extends IFileService {
  // Constructor
  EpubFileService({required super.logger, required super.dataStoragePrefs})
    : super(serviceID: 'epub', acceptedExtensions: ['.epub']);

  // Methods
  @override
  Future<String> saveFile(WorkModel work, String filePath) async {
    try {
      // Create book
      var archive = Archive();
      final mimetypeUTF8 = utf8.encode('application/epub+zip');
      archive.addFile(
        ArchiveFile('mimetype', mimetypeUTF8.length, mimetypeUTF8),
      );

      // Create META-INF/container.xml
      final containerXml = xml.XmlBuilder();
      containerXml.processing('xml', 'version="1.0" encoding="UTF-8"');
      containerXml.element(
        'container',
        attributes: {
          'version': '1.0',
          'xmlns': 'urn:oasis:names:tc:opendocument:xmlns:container',
        },
        nest: () {
          containerXml.element(
            'rootfiles',
            nest: () {
              containerXml.element(
                'rootfile',
                attributes: {
                  'full-path': 'OEBPS/content.opf',
                  'media-type': 'application/oebps-package+xml',
                },
              );
            },
          );
        },
      );
      final containerXmlString = containerXml.buildDocument().toXmlString(
        pretty: true,
      );
      archive.addFile(
        ArchiveFile(
          'META-INF/container.xml',
          utf8.encode(containerXmlString).length,
          utf8.encode(containerXmlString),
        ),
      );

      // Create OEBPS/content.opf
      final contentOpf = xml.XmlBuilder();
      contentOpf.processing('xml', 'version="1.0" encoding="UTF-8"');
      contentOpf.element(
        'package',
        nest: () {
          contentOpf.attribute('version', '3.0');
          contentOpf.attribute('xmlns', 'http://www.idpf.org/2007/opf');
          contentOpf.element(
            'metadata',
            nest: () {
              // Attributes for metadata
              contentOpf.attribute(
                'xmlns:dc',
                'http://purl.org/dc/elements/1.1/',
              );
              contentOpf.attribute('xmlns:opf', 'http://www.idpf.org/2007/opf');
              // Add metadata elements
              // - Identifier
              contentOpf.element(
                'dc:identifier',
                nest: 'selene-uid:${work.id}',
                attributes: {'id': 'selene-uid'},
              );
              // - Title
              contentOpf.element('dc:title', nest: work.title);
              // - Source URL
              if (work.sourceURL != null) {
                contentOpf.element('dc:source', nest: work.sourceURL!);
                contentOpf.element(
                  'dc:identifier',
                  nest: work.sourceURL!,
                  attributes: {'opf:scheme': 'URL', 'id': 'source-url'},
                );
              }
              // - Authors
              for (var author in work.authors) {
                // Author name and URL (in a single element)
                contentOpf.element(
                  'dc:creator',
                  nest: () {
                    contentOpf.attribute('opf:role', 'aut'); // Author role
                    contentOpf.text(author.name);
                    if (author.sourceURL != null) {
                      contentOpf.attribute('opf:file-as', author.sourceURL!);
                    }
                  },
                );
              }
              // - Summary (note that the summary is an HTML string that needs to be nested inside XML tags)
              if (work.summary != null) {
                contentOpf.element('dc:description', nest: work.summary!);
              }
              // - Fandom(s)
              for (var fandom in work.fandoms) {
                contentOpf.element(
                  'dc:subject',
                  nest: fandom.name,
                  attributes: {
                    'opf:file-as':
                        fandom.sourceURLs.isNotEmpty
                            ? fandom.sourceURLs.first
                            : fandom.name,
                  },
                );
              }
              // - Tags (need to be NOT dc:subject tags, but custom meta tags)
              for (var tag in work.tags) {
                contentOpf.element(
                  'meta',
                  nest: tag.name,
                  attributes: {
                    'name': 'selene-tag-${tag.type.name.toLowerCase()}',
                    'content': tag.name,
                    'type': tag.type.name.toLowerCase(),
                    'opf:file-as': tag.sourceURL ?? tag.name,
                    'href': tag.sourceURL ?? '',
                  },
                );
              }
              // - Date File Created
              contentOpf.element(
                'dc:date',
                nest: DateTime.now().toIso8601String(),
                attributes: {'opf:event': 'creation'},
              );
              // - Date Published
              if (work.datePublished != null) {
                contentOpf.element(
                  'dc:date',
                  nest: work.datePublished!.toIso8601String(),
                  attributes: {'opf:event': 'publication'},
                );
              }
              // - Date Updated
              if (work.dateUpdated != null) {
                contentOpf.element(
                  'dc:date',
                  nest: work.dateUpdated!.toIso8601String(),
                  attributes: {'opf:event': 'update'},
                );
              }
              // - Language
              contentOpf.element(
                'dc:language',
                nest: 'en', // Default to English; can be changed later
              );
              // - Work Status
              contentOpf.element(
                'meta',
                nest: work.status.label,
                attributes: {
                  'name': 'selene-work-status',
                  'content': work.status.label,
                },
              );
              // - Cover Image (if available)
              if (work.coverURL != null) {
                contentOpf.element(
                  'meta',
                  nest: work.coverURL!,
                  attributes: {
                    'name': 'selene-cover-image',
                    'content': work.coverURL!,
                  },
                );
              }
              // - Word Count
              if (work.wordCount != null) {
                contentOpf.element(
                  'meta',
                  nest: work.wordCount.toString(),
                  attributes: {
                    'name': 'selene-word-count',
                    'content': work.wordCount.toString(),
                  },
                );
              }
            },
          );
          contentOpf.element(
            'manifest',
            nest: () {
              // Add manifest items for each file

              // TOC file
              contentOpf.element(
                'item',
                attributes: {
                  'id': 'toc',
                  'href': 'toc.ncx',
                  'media-type': 'application/x-dtbncx+xml',
                },
              );

              // Stylesheet
              contentOpf.element(
                'item',
                attributes: {
                  'id': 'stylesheet',
                  'href': 'stylesheet.css',
                  'media-type': 'text/css',
                },
              );

              // Title page
              contentOpf.element(
                'item',
                attributes: {
                  'id': 'title-page',
                  'href': 'title.xhtml',
                  'media-type': 'application/xhtml+xml',
                },
              );
              // TODO: Implement info page
              // contentOpf.element(
              //   'item',
              //   attributes: {
              //     'id': 'info-page',
              //     'href': 'info.xhtml',
              //     'media-type': 'application/xhtml+xml',
              //   },
              // );
              // Add chapters here
              for (var chapter in work.chapters) {
                final fileIndex = chapter.index.toString().padLeft(
                  4,
                  '0',
                ); // e.g., chapter-0001
                contentOpf.element(
                  'item',
                  attributes: {
                    'id': 'chapter-$fileIndex',
                    'href': 'chapter-$fileIndex.xhtml',
                    'media-type': 'application/xhtml+xml',
                  },
                );
              }
            },
          );
          contentOpf.element(
            'spine',
            nest: () {
              // Define the spine items (the reading order)
              contentOpf.element(
                'itemref',
                attributes: {'idref': 'title-page', 'linear': 'yes'},
              );
              // contentOpf.element(
              //   'itemref',
              //   attributes: {'idref': 'info-page', 'linear': 'yes'},
              // );
              // Add chapters here
              for (var chapter in work.chapters) {
                final fileIndex = chapter.index.toString().padLeft(
                  4,
                  '0',
                ); // e.g., chapter-0001
                contentOpf.element(
                  'itemref',
                  attributes: {'idref': 'chapter-$fileIndex', 'linear': 'yes'},
                );
              }
            },
          );
        },
      );
      final contentOpfXml = contentOpf.buildDocument().toXmlString(
        pretty: true,
      );
      archive.addFile(
        ArchiveFile(
          'OEBPS/content.opf',
          utf8.encode(contentOpfXml).length,
          utf8.encode(contentOpfXml),
        ),
      );

      // Create OEBPS/toc.ncx (Table of Contents)
      final tocNcx = xml.XmlBuilder();
      tocNcx.processing('xml', 'version="1.0" encoding="UTF-8"');
      tocNcx.element(
        'ncx',
        attributes: {
          'xmlns': 'http://www.daisy.org/z3986/2005/ncx/',
          'version': '2005-1',
        },
        nest: () {
          tocNcx.element(
            'head',
            nest: () {
              tocNcx.element(
                'meta',
                attributes: {'name': 'dtb:uid', 'content': work.id.toString()},
              );
              tocNcx.element(
                'meta',
                attributes: {'name': 'dtb:depth', 'content': '1'},
              );
              tocNcx.element(
                'meta',
                attributes: {'name': 'dtb:totalPageCount', 'content': '0'},
              );
              tocNcx.element(
                'meta',
                attributes: {'name': 'dtb:maxPageNumber', 'content': '0'},
              );
            },
          );
          tocNcx.element(
            'docTitle',
            nest: () {
              tocNcx.element('text', nest: work.title);
            },
          );
          tocNcx.element(
            'navMap',
            nest: () {
              // Add title page entry
              tocNcx.element(
                'navPoint',
                attributes: {'id': 'title-page', 'playOrder': '0'},
                nest: () {
                  tocNcx.element(
                    'navLabel',
                    nest: () {
                      tocNcx.element('text', nest: work.title);
                    },
                  );
                  tocNcx.element('content', attributes: {'src': 'title.xhtml'});
                },
              );
              // TODO: Add info page entry
              // tocNcx.element(
              //   'navPoint',
              //   attributes: {'id': 'info-page', 'playOrder': '1'},
              //   nest: () {
              //     tocNcx.element(
              //       'navLabel',
              //       nest: () {
              //         tocNcx.element('text', nest: 'Information');
              //       },
              //     );
              //     tocNcx.element('content', attributes: {'src': 'info.xhtml'});
              //   },
              // );
              // Add chapters
              for (var chapter in work.chapters) {
                final fileIndex = chapter.index.toString().padLeft(
                  4,
                  '0',
                ); // e.g., chapter-0001
                tocNcx.element(
                  'navPoint',
                  attributes: {
                    'id': 'chapter-$fileIndex',
                    'playOrder': '${chapter.index + 1}',
                  },
                  nest: () {
                    tocNcx.element(
                      'navLabel',
                      nest: () {
                        tocNcx.element('text', nest: chapter.title);
                      },
                    );
                    tocNcx.element(
                      'content',
                      attributes: {'src': 'chapter-$fileIndex.xhtml'},
                    );
                  },
                );
              }
            },
          );
        },
      );
      final tocNcxXml = tocNcx.buildDocument().toXmlString(pretty: true);
      archive.addFile(
        ArchiveFile(
          'OEBPS/toc.ncx',
          utf8.encode(tocNcxXml).length,
          utf8.encode(tocNcxXml),
        ),
      );

      // Add title page
      final titleHTML = await _generateTitlePageHtml(work);
      archive.addFile(
        ArchiveFile(
          'OEBPS/title.xhtml',
          utf8.encode(titleHTML).length,
          utf8.encode(titleHTML),
        ),
      );

      // TODO: Add info page
      // archive.addFile(
      //   ArchiveFile(
      //     'OEBPS/info.xhtml',
      //     _generateInfoPageHtml(work).length,
      //     utf8.encode(_generateInfoPageHtml(work)),
      //   ),
      // );

      // Add chapters
      for (var chapter in work.chapters) {
        final fileIndex = chapter.index.toString().padLeft(
          4,
          '0',
        ); // e.g., chapter-0001
        final chapterHTML = await _generateChapterHtml(chapter, work.title);
        archive.addFile(
          ArchiveFile(
            'OEBPS/chapter-$fileIndex.xhtml',
            utf8.encode(chapterHTML).length,
            utf8.encode(chapterHTML),
          ),
        );
      }

      // Add stylesheet
      final stylesheetCSS = await _generateStylesheet();
      archive.addFile(
        ArchiveFile(
          'OEBPS/stylesheet.css',
          utf8.encode(stylesheetCSS).length,
          utf8.encode(stylesheetCSS),
        ),
      );

      // Write the archive to the file system
      final file = File(filePath);
      if (!(await file.parent.exists())) {
        await file.parent.create(recursive: true);
      }
      await file.writeAsBytes(ZipEncoder().encode(archive) ?? []);
      logger.i('EPUB file saved at $filePath');

      return filePath;
    } catch (e) {
      logger.e('Failed to save EPUB file: $e');
      rethrow; // Rethrow the exception to handle it upstream
    }
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

      // Decode the archive
      final archive = ZipDecoder().decodeBytes(epubData);
      if (archive.isEmpty) {
        logger.e('EPUB file is corrupted or empty at $filePath');
        return null; // Return null if archive is empty
      }

      // Files to be read:
      // - META-INF/container.xml (container file) (this tells us where the content.opf is)
      // - ?/content.opf (metadata)
      // - ?/toc.ncx (table of contents)
      // - OEBPS
      //   - *.xhtml (content files)
      //   - *.css (stylesheets)

      // Read in the container file to find the content.opf path
      final containerFile = archive.firstOrNullWhere(
        (file) => file.name == 'META-INF/container.xml',
      );
      if (containerFile == null) {
        logger.e('Container file not found in EPUB at $filePath');
        return null; // Return null if container file is missing
      }
      final containerXml = xml.XmlDocument.parse(
        utf8.decode(containerFile.content),
      );
      final rootFileElement =
          containerXml.findAllElements('rootfile').firstOrNull;
      final contentPath = rootFileElement?.getAttribute('full-path');
      if (contentPath == null) {
        logger.e('Content path not found in container file at $filePath');
        return null; // Return null if content path is missing
      }

      // Read the content.opf file
      final contentFile = archive.firstOrNullWhere(
        (file) => file.name == contentPath,
      );
      if (contentFile == null) {
        logger.e('Content file not found in EPUB at $filePath');
        return null; // Return null if content file is missing
      }
      final contentXml = xml.XmlDocument.parse(
        utf8.decode(contentFile.content),
      );

      // Parse the EPUB data
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
  String _processHtmlContent(String? htmlString, String fallback) {
    if (htmlString == null || htmlString.trim().isEmpty) {
      return fallback;
    }
    try {
      final document = parseFragment(htmlString);
      // The outerHtml property serializes the parsed fragment back to a string,
      // ensuring valid structure and entity handling.
      final outerHtml = document.outerHtml
          .replaceAll('&nbsp;', ' ')
          .replaceAll('<hr>', '<hr/>')
          .replaceAll('<br>', '<br/>');
      return outerHtml;

      final shouldBeGood = HtmlUnescape().convert(outerHtml);
      // If the HTML is well-formed, return it directly
      return shouldBeGood;
    } catch (e, s) {
      logger.w(
        'Failed to parse HTML fragment, using raw string.',
        error: e,
        stackTrace: s,
      );
      // Basic fallback: return original string (maybe with common fixes if needed)
      bool notFixed = htmlString.contains('&nbsp;');
      if (notFixed) {
        logger.w('HTML string contains &nbsp; entities, replacing them.');
      }
      return htmlString
          .replaceAll('&nbsp;', ' ')
          .replaceAll('<hr>', '<hr/>')
          .replaceAll('<br>', '<br/>');
    }
  }

  Future<String> _generateTitlePageHtml(WorkModel work) async {
    // Load template for title page HTML
    final titleTemplate = await _loadTemplate('title_page_template.xhtml');
    final summaryHTML = _processHtmlContent(
      work.summary,
      'No summary available.',
    );

    final templateData = {
      'title': sanitize(work.title),
      'url': work.sourceURL ?? '#',
      'authors':
          work.authors
              .map((a) => {'name': sanitize(a.name), 'url': a.sourceURL ?? '#'})
              .toList(),
      'fandoms':
          work.fandoms
              .map((f) => {'name': sanitize(f.name), 'url': f.sourceURLs.first})
              .toList(),
      'series':
          work.series.isNotEmpty
              ? work.series
                  .map((s) => {'title': sanitize(s.title), 'url': s.sourceURL})
                  .toList()
              : null, // Use null for conditional check {{#series_html}}
      'summary_html': summaryHTML, // Already HTML, use {{{ }}} in template
      'word_count': work.wordCount?.toString() ?? 'N/A',
      'status_label': work.status.label,
      'date_published':
          work.datePublished?.toLocal().toIso8601String().split('T').first ??
          'N/A',
      'date_updated':
          work.dateUpdated?.toLocal().toIso8601String().split('T').first ??
          'N/A',
      // Add boolean flags if needed for more complex conditionals,
      // but Mustache often handles non-empty strings/lists correctly for {{#...}}
      'has_series': work.series.isNotEmpty, // Example boolean flag
    };

    // Populate template
    final populatedTemplate = titleTemplate.renderString(templateData);

    return populatedTemplate;
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

  Future<String> _generateChapterHtml(
    ChapterModel chapter,
    String workTitle,
  ) async {
    // Load template for chapter HTML
    final chapterTemplate = await _loadTemplate('chapter_template.xhtml');

    // Process chapter content and other fields
    String chapterContent = _processHtmlContent(
      chapter.content,
      '<p>No content available for this chapter.</p>',
    );
    final chapterSummary = _processHtmlContent(chapter.summary, '');
    final chapterStartNotes = _processHtmlContent(chapter.startNotes, '');
    final chapterEndNotes = _processHtmlContent(chapter.endNotes, '');

    // Gather data
    final templateData = {
      'chapter_title': sanitize(chapter.title),
      'chapter_url': chapter.sourceURL ?? '',
      'chapter_index': chapter.index.toString(),
      // For conditionals: Pass the content if not empty, otherwise pass null/false
      // Mustache treats non-empty strings as "truthy" for {{#...}} sections
      'chapter_summary': chapterSummary.isNotEmpty ? chapterSummary : null,
      'chapter_start_notes':
          chapterStartNotes.isNotEmpty ? chapterStartNotes : null,
      'chapter_content':
          chapterContent, // Assumed to always have content (even if default)
      'chapter_end_notes': chapterEndNotes.isNotEmpty ? chapterEndNotes : null,
      'work_title': sanitize(workTitle),
      'chapter_date_published':
          chapter.datePublished?.toLocal().toIso8601String().split('T').first ??
          'N/A',
    };

    // Populate the chapter template
    String populatedChapter = chapterTemplate.renderString(templateData);

    return populatedChapter;
  }

  Future<String> _generateStylesheet() async {
    // Basic CSS for the EPUB
    final stylesheetTemplate = await _loadTemplate('stylesheet.css');
    return stylesheetTemplate.renderString({});
  }

  Future<Template> _loadTemplate(String templateFile) async {
    String templateString = await rootBundle.loadString(
      'assets/templates/epub/$templateFile',
    );
    return Template(templateString, htmlEscapeValues: false);
  }

  String sanitize(String unsafe) {
    final unsafeChars = ['<', '>', '&', '"', "'"];
    final safeChars = ['&lt;', '&gt;', '&amp;', '&quot;', '&#39;'];
    var sanitized = unsafe;
    for (var i = 0; i < unsafeChars.length; i++) {
      sanitized = sanitized.replaceAll(unsafeChars[i], safeChars[i]);
    }
    return sanitized;
  }
}
