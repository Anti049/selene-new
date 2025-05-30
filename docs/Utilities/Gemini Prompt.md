I am developing a Flutter application that will serve as a reader/browser/downloader for eBooks created from fanfiction works. The application will be designed to work with works from various sources, such as Archive of Our Own (AO3), FanFiction.net, and others. The primary goal is to provide a seamless reading experience while allowing users to manage their library of works effectively.

  

I am utilizing a feature-first architecture for the application, which means that each feature will be developed as a separate module with its own functionality. This will allow for better organization of the codebase and easier maintenance in the long run. The application will be structured around the following features:

  

-   Main Screen: Bottom navigation between the following features:

    -   Library: A page to view all works in the application

        -   Details: A page to view detailed information about a work

            -   This will include metadata such as title, author(s), fandom(s), series, published date, updated/completed date, cover image, and a list of chapters

            -   Users can open the work in the reader from this page

            -   Users can bookmark chapters, highlight text, and view detailed information about each chapter

        -   Reader: A page to read works from their corresponding file

            -   Users can navigate through chapters, bookmark chapters, highlight text, and view detailed information about the work

            -   Users can choose between different reading modes (vertical scrolling, horizontal scrolling, page-by-page, infinite scrolling)

            -   Users can view a table of contents (TOC) for the work

            -   Users can view a list of bookmarks and highlights for the work

            -   Users can view indicators for words/phrases that have more information available (similar to Kindle's "X-Ray" feature)

            -   Users can view an options bar (configurable in More -> Settings -> Reader)

                -   Options will include:

                    -   Screen Orientation

                    -   Theme Mode (Light/Dark/Auto)

                    -   Player Mode (future feature to allow text-to-speech reading of the work)

                    -   Auto-Scroll (future feature to allow automatic scrolling of the work)

                    -   Bookmarks (to view a list of bookmarks for the work)

                    -   X-Ray (to view a list of indicators for words/phrases in the work)

                    -   Brightness (to adjust the brightness of the reader, can also be adjusted by dragging up/down on the left/right side of the screen (configurable in preferences))

                    -   Font Size (to adjust the font size of the reader, can also be adjusted by pinching in/out on the screen)

                    -   Search (to search for text in the work)

                    -   Visual Options (to configure reader-specific visual options, such as font family, line height, paragraph spacing, etc.)

                    -   Control Options (to configure reader-specific control options, such as tap zones, swipe gestures, etc.)

                    -   Themes (to select a theme for the reader, can be set to application theme or reader-specific theme)

                    -   Sync to Cloud (future feature to allow syncing of the work to a cloud service for backup and synchronization across devices)

                    -   Sync from Cloud (future feature to allow syncing of the work from a cloud service for backup and synchronization across devices)

                    -   Check for Updates (to check for updates to the work)

    -   Updates: A page to view work update history

    -   History: A page to view a history of read works

    -   Browse: A top-tabbed page to navigate between the following:

        -   Sources: A page to view all sources in the application

            -   Clicking on a source will allow the user to browse works from that source

        -   Extensions: A page that in the future will (theoretically) allow the application to only ship with shared core functionality, and let additional features be added via extensions (similar to Tachiyomi/Mihon's extension system)

            -   Extensions will be able to add new sources, new eBook file formats, new features, etc.

        -   TBD, but is currently Migrate: A page to check for works that are cross-posted between sources (where one source might have more chapters than another) or authors that have accounts in different sources (where one source might have different works than another)

    -   More: A page to navigate to the following:

        -   Downloaded Only: A switch to toggle between showing only works/chapters that are downloaded in the library and all works/chapters attached to the configured sources/accounts/cloud backup

        -   Incognito Mode: A switch to toggle between saving user actions (such as reading history, bookmarks, highlights, etc.) and not saving them

        -   Download Queue: A page to view the current download queue

        -   Categories: A page to view configured categories for the library/searching

            -   A category is defined as a set of configured tags, languages, fandoms, etc. that will be used to filter works in the library

                -   Example: A filter for "My Hero Academia" works that are in English, include the "Midoriya Izuku/Uraraka Ochako" romantic pairing, and contain the "Midoriya Izuku Does Not Have One-for-All" tag

            -   Categories will be visible as tabs in the library page (if tabs are enabled in Library preferences) or in the library search screen

        -   Statistics: A page to view statistics about the user's library

            -   This will include:

                -   Total number of works

                -   Total number of chapters

                -   Total number of words

                -   Most read works

                -   Most read authors

                -   Most read fandoms

                -   Most read tags

        -   Data & Storage: A page to manage the application's data and storage

            -   This will include:

                -   Set library folder (where works are stored)

                -   View used/available storage space

                -   Clear cache

                -   Clear database

                -   Export/Import data

                -   Backup/Restore data

        -   Settings: A series of pages to configure user preferences

            -   Appearance: A page to configure the application's appearance

                -   This will include:

                    -   Theme (Light/Dark/Auto)

                    -   Theme Selection: A page to select an application theme and create custom themes

                        -   Users can select a theme from a list of pre-defined themes

                        -   Users can create custom themes by selecting colors for:

                            -   Primary color

                            -   Secondary color

                            -   Tertiary color

                            -   Neutral color

                            -   Error color

                        -   Users can generate a theme based on an image

                            -   Uses Google's Material You color extraction algorithm to extract colors from an image

                    -   E-Ink Mode: A switch to toggle between a regular mode and an e-ink mode

                        -   E-Ink mode will use a high-contrast color scheme and disable animations

                    -   Pure Black Mode: A switch to toggle between a regular mode and a pure black mode

                        -   Pure black mode will use a pure black color scheme for OLED screens

                    -   Font Size: A slider to adjust the font size of the application

                        -   This will affect the font size of the application text, including the library, reader, and other pages

                    -   Font Family: A dropdown to select the font family for the application

                        -   This will allow users to select a font family for the application text

                        -   Users can choose from a list of pre-defined font families or add custom font files

                    -   Tablet UI: A switch to toggle between a phone UI and a tablet UI

                        -   Tablet UI will use a larger layout with more space for content and a navigation rail instead of bottom navigation

                    -   Date Format: A dropdown to select the date format for the application

                    -   Relative Timestamps: A switch to toggle between absolute timestamps (e.g., "2023-10-01 12:00") and relative timestamps (e.g., "2 days ago")

            -   Library

                -   Categories: A page to configure the categories discussed above (links to the same page as the "Categories" page in the "More" section)

                -   Per-Category Settings for Sort

                -   Automatic Updates: A dropdown to configure automatic update check frequency for the background service

                    -   Options will include:

                        -   Off

                        -   Every 12 Hours

                        -   Daily

                        -   Every 2 Days

                        -   Every 3 Days

                        -   Weekly

                        -   Custom (allows the user to set a custom frequency in a CRON-like format)

                -   Automatically Refresh Metadata: A switch to toggle between automatically refreshing work metadata on an update and manually refreshing metadata

                    -   This setting can be modified here on a global basis, on a per-category basis, or on a per-work basis

                -   Smart Updates: A switch to toggle between normal update behavior and smart update behavior

                    -   Smart updates will only update works that do not have the "Completed" status, do not have unread chapter(s), and have not been started reading in the last X days (configured by the user)

                -   Smart Update Days: A slider to configure the number of days for smart updates

                -   Chapter Swipe Behavior: A dropdown to select the action to take when swiping chapter items left/right in the Details screen

                    -   Options will include:

                        -   None (default)

                        -   Mark as Read/Unread

                        -   Bookmark/Unbookmark

                        -   Favorite/Unfavorite

                        -   Queue for Download/Remove from Download Queue

            -   Accounts: A page to manage user accounts for sources

                -   Users can add, remove, and edit accounts for sources

                -   Users can configure account settings for each source

                    -   This will include:

                        -   Username

                        -   Password (if applicable)

                        -   API Key (if applicable)

                        -   Other source-specific settings

            -   Reader: A page to configure the reader settings

                -   This will include:

                    -   Reader Mode: A dropdown to select the reader mode

                        -   Options will include:

                            -   Vertical Scrolling

                            -   Horizontal Scrolling

                            -   Page-by-Page

                            -   Infinite Scrolling

                    -   Show Reading Mode: A switch to toggle briefly showing the current reading mode when opening a work

                    -   Show Tap Zones Overlay: A switch to toggle briefly showing tap zones for navigating chapters in the reader when opening a work

                    -   Animate Page Transitions: A switch to toggle between animated and static page transitions in the reader

                    -   Screen Orientation: A dropdown to select the default rotation for the reader

                        -   Options will include:

                            -   Portrait

                            -   Landscape

                            -   Auto (based on device orientation)

                    -   Option Bar: A dialog to reorder the option bar buttons in the reader

            -   Downloads

            -   Tracking

            -   Browse

            -   Notifications

            -   Data & Storage (link to the Data & Storage page)

            -   Security & Privacy

            -   Advanced

            -   About (link to the About page)

        -   About: A page to view information about the application

            -   This will include:

                -   Version number

                -   License information

                -   Changelogs

                -   Credits for contributors and libraries used in the application

        -   Help & Support: A page to view help and support information

            -   This will include:

                -   User Guide

                -   FAQ

                -   Contact information for support

                -   Links to the application's GitHub repository and issue tracker

  

The packages I'm currently using in the application include the following (feel free to recommend better alternatives if there are any, except where explicitly stated otherwise). Please look at my pubspec.yaml for any packages I haven't specified by name and their versions:

  

-   Riverpod: For state management

-   Isar: For database management

-   Freezed: For data classes and immutability

-   Flex Color Scheme: For theming and color management

-   Auto Route: For routing and navigation

-   Draggable Menu: For creating a resizable bottom sheet for the library sort/filter/display/tag options

-   Dio: For making HTTP requests

-   BeautifulSoup Dart: For parsing HTML content

-   Easy Refresh: What I'm currently using for vertical paging and vertical scrolling in the reader

-   (Formerly) Epubx: I was using epubx to parse EPUB files, but documentation on actually CREATING EPUB files with it is nonexistent, so I scrapped it in favor of writing my own EPUB file reading/writing logic using the archive package to read/write ZIP files and the xml package to read/write XML files

-   Flutter Local Notifications: For displaying notifications, haven't gotten a notification to display yet

-   Logger: For logging

-   RXDart: For reactive programming and streams

  

The application has a good amount of barebones functionality already implemented, but requires refining and simplification of the codebase. The current implementation uses Isar for database management, but I am looking to refactor the code to store only metadata in the database while keeping the actual content of the works in eBook files. This will allow for better performance and easier management of works. In the future, I would like to explore options for cloud backup and synchronization to allow for a fluid experience between devices (similar to how Chrome and Firefox allow tab syncing between devices), but for now, the focus will be on local storage and management.

  

My current objectives are the following:

  

-   Works

  

    -   Hosted on various fanfiction sites (AO3, FFN, etc.)

    -   Will be scraped for metadata and content

        -   Sites my be protected by Cloudflare, so the application will need to handle that

            -   The application will primarily run on Android, so the approach needs to account for that

            -   Could possibly is an in-app webview (maybe headless?) to scrape the content on CloudFlare-protected sites

            -   Might also hook into a remote FlareSolverr instance to handle CloudFlare protection

    -   Metadata

        -   Stored in the database

        -   Defined as:

            -   Title

            -   Author(s)

                -   Name

                -   URL (for linking to author pages)

            -   File Path (location of the eBook file)

            -   Last Read Position (to track where the user left off)

            -   Fandom(s)

                -   Name

                -   URL (for linking to fandom pages)

            -   List of Aliases

                -   An alias is a name that the fandom is known by, to correct parsed fandoms to the correct name

                    -   Example:

                        -   Fandom Name: "My Hero Academia"

                        -   Aliases:

                            -   "Boku no Hero Academia"

                            -   "MHA"

                            -   "BnHA"

                            -   "僕のヒーローアカデミア"

                        -   In this case, if the parser finds "Boku no Hero Academia", it will be corrected to "My Hero Academia"

            -   List of Tags

                -   Name

                -   Type

                    -   Info

                        -   For general-purpose things like Genre, Rating, Language, etc.

                    -   Character

                        -   For characters in the work

                    -   Friendship

                        -   For relationships that are platonic

                        -   Will have related tags for the characters involved

                    -   Romance

                        -   For relationships that are romantic

                        -   Will have related tags for the characters involved

                    -   Freeform

                        -   For tags that don't fit into the other categories

                        -   These are assorted tags that individual authors will add to their works arbitrarily

                -   URL (for linking to tag pages, if applicable)

                -   Related Tags

                    -   Tags for characters involved in any friendship or romance tags

                    -   If these tags are not already present in the Character tag list, they will be added

            -   List of Series

                -   Name

                -   URL (for linking to series pages)

                -   List of Works

            -   Number of Chapters

            -   Number of Words

            -   Date Published

            -   Date Updated/Completed

            -   Current Status

                -   Unknown (default)

                -   In-Progress

                -   Completed

                -   On Hiatus (may need to be set manually by the user)

                -   Abandoned (if the work hasn't been updated in X amount of time, configured by the user)

            -   Reading Position

                -   The position in the work where the user left off

                -   This will be saved in the database when the user closes the work or navigates away

                -   It will be restored when the user opens the work again

                -   It will be updated as the user reads

            -   List of Chapters

                -   Each chapter will have its own metadata

                -   This will allow for easy navigation and management of chapters

                -   Chapters will be stored in the eBook file as HTML strings, allowing for easy rendering in the application

                -   Chapter metadata will be pulled of work refreshes from the work URL, to be compared against the file

                -   New chapters (chapters that exist in the source and are copied to the database, but do not exist in the file) can be individually added to the download queue

    -   Content

        -   Stored in a file (EPUB, PDF, HTML, MOBI)

        -   The content should be readable by the application

            -   This will allow users to read the works directly from the application

            -   ReaderRoute will be used to display the content

        -   Content is saved as HTML strings in the eBook file

            -   This allows for easy rendering in the application

            -   A Chapter contains:

                -   Title

                -   Index (to determine the order of chapters)

                -   URL (for linking to the chapter page)

                -   Date Published (to show when the chapter was published)

                -   Word Count (to show the length of the chapter)

                -   Summary (optional, for a brief overview of the chapter)

                -   Start Notes (optional, goes before the chapter content)

                -   Content (the main body of the chapter)

                -   End Notes (optional, goes after the chapter content)

                -   Is Read Flag (to indicate if the chapter has been read)

                -   Is Downloaded Flag (to show if the work's file contains the chapter)

                    -   Works may have chapters that are not downloaded

                    -   This will be determined by comparing the chapter list in the file with the chapters in the database

                    -   If a chapter exists in the database but not in the file, it will be marked as not downloaded

  

-   Library

  

    -   A page to view all works in the application

    -   Users can filter works by:

        -   Title

        -   Author

        -   Fandom

        -   Tags

        -   Series

        -   Status (In-Progress, Completed, On Hiatus, Abandoned)

        -   Read/Unread Status

    -   Users can sort works by:

        -   Title

        -   Author

        -   Fandom

        -   Date Published

        -   Date Updated/Completed

        -   Number of Chapters

        -   Number of Words

    -   Users can search for works by:

        -   Title

        -   Author

        -   Fandom

        -   Tags

        -   Series

    -   Users can select works to perform bulk actions

        -   Selection mode can be enabled by long-pressing a work

        -   In selection mode, tapping a work adds/removes it from the selection

        -   In selection mode, long-pressing a work selects it and all works between it and the last selected work

    -   Users can view detailed information about each work

        -   This will include the metadata defined above

        -   Users can click on a work to open it in the reader

    -   The Library screen should implement pull-to-refresh functionality

        -   Refreshing will:

            -   Manually re-poll the database for work metadata

            -   Manually re-poll the library folder for new files

            -   Check the user's configured source for work updates (information in the Accounts section)

    -   The Library should be smoothly and seemlessly updated when works are added/removed to the database/library folder

        -   This will allow users to see new works immediately without having to refresh the page

        -   Updates should be smooth (new items simply appear, and deleted items disappear, rather than the entire list being reloaded)

        -   When new files are added to the library folder:

            -   The application will extract metadata from the file(s)

            -   The application will check that metadata against the database to determine if the work already exists

                -   If the work exists, it will update the metadata in the database

                -   If the work does not exist, it will add the work to the database with the extracted metadata

            -   The application will then update the Library screen to show the new work

        -   When a new work is added via URL inside the application:

            -   The work metadata will be scraped from the source

            -   The application will check if the work already exists in the database

                -   If the work exists, it will update the metadata in the database

                -   If the work does not exist, it will add the work to the database with the scraped metadata

            -   The application will generate a cover image for the work (if not already available)

            -   The application will generate a new file for the work (if not already available)

                -   The file will be generated based on the scraped metadata and the content of the work

            -   The application will then update the Library screen to show the new work

    -   The Library should support multiple views

        -   List Items: A standard list view with works displayed as list items

            -   Each item will display the work's title, author(s), fandom(s), and cover image (if available)

            -   The item may show a Continue Reading button (user preference to enable/disable)

            -   Tapping on an item will open the work in the Details screen

        -   Grid Items: A grid view with works displayed as grid items

            -   Each item will display the work's cover image (if available), title, and author(s)

            -   The item may show a Continue Reading button (user preference to enable/disable)

            -   Tapping on an item will open the work in the Details screen

        -   Card Items: A card view with works displayed as cards

            -   Each card will display the work's title, author(s), fandom(s), and an expandable tags section

            -   The card may show a Continue Reading button (user preference to enable/disable)

            -   Tapping on a card will open the work in the Details screen

  

-   Details

  

    -   Will show metadata for a work

        -   Title

        -   Author(s)

        -   Fandom(s)

        -   Series

        -   Published Date

        -   Updated/Completed Date

        -   Cover Image (if available)

            -   If not available, a cover image will be generated when the work is downloaded

                -   Modeled off the cover image generation in Calibre

                -   Background, colors, fonts, text, and other elements will be customizable by the user

    -   Modeled off the manga details page from Tachiyomi/Mihon

    -   Will have expandable section for work summary and tag section

        -   Clicking the expand button will expand both sections

        -   Tags will be separated by tag type

            -   When contracted, sections will be horizontally scrollable

            -   When expanded, sections will wrap and take up as much height as they need to display all tags

    -   Will have an action button section

        -   Add to/Remove from Favorites

        -   Add to/Remove from Reading List

        -   Update Prediction

            -   Will use the work's status previous update history, the current date, and any notes in the last few chapters to predict when the next chapter will be released

            -   Button text will be one of the following:

                -   Completed (button will be disabled)

                -   On Hiatus (button will be disabled)

                -   Abandoned (button will be disabled)

                -   Updating Soon (if the next chapter is expected to be released soon)

                -   Updating (if the next chapter is expected to be released in the future)

        -   Notify on Update

            -   Will mark the work to send an update notification when the next chapter is released

            -   Enabled/Disabled by default depending on user preferences

        -   Open in WebView/Browser

            -   Will open the work's page in a WebView or external browser

            -   Will be based on a user preference

    -   Will have a list of chapters for the work

        -   Chapters will be displayed in a vertically scrollable list

        -   Each chapter will have its own metadata displayed

            -   Title

            -   Index

            -   Read/Unread Status

            -   Downloaded Status

        -   Users can tap on a chapter to open it in the reader

            -   If the chapter is downloaded, it will open the chapter from the file

            -   If the chapter is not downloaded, it will prompt the user to download the chapter

                -   If the user chooses to download the chapter, it will be inserted at the top of the download queue with maximum priority

                    -   Will display a loading screen with the download progress while the chapter is being downloaded

                    -   When the download is completed and the chapter has been added to the file, the chapter will be opened in the reader

                -   If the chapter is already in the download queue, it will be moved to the top of the queue with maximum priority

                -   If the user chooses not to download the chapter, the action will be canceled

        -   Users can tap on a trailing icon button to queue the chapter for download

            -   If the chapter is already downloaded, the button will be disabled, and a checkmark will be displayed instead

            -   If the chapter is not downloaded, the button will be enabled and will add the chapter to the download queue

        -   Users can tap of a leading icon to mark it as read/unread

            -   If the chapter is read, the icon will be filled

            -   If the chapter is unread, the icon will be outlined

        -   Long-pressing a chapter will enable selection mode

            -   Users can select multiple chapters to perform bulk actions

                -   Mark as read/unread

                -   Queue for download

                -   Remove from the work (if the chapter is not downloaded)

    -   Will have a floating action button to continue reading from the last read position

        -   If the work has not been read before, it will open the first chapter

        -   If the work has been read before, it will open the chapter at the last read position

  

-   Reader

  

    -   Will be able to read works from their corresponding file

    -   Will display the content of the work in a readable format

    -   Will allow users to navigate through chapters

        -   Users can go to the next/previous chapter

        -   Users can jump to a specific chapter via the TOC drawer

    -   Users can page through the work:

        -   Via horizontal paging for each chapter

            -   Each page will be a vertically scrollable chapter

        -   Via vertical paging for each chapter

            -   Each chapter will be a vertically scrollable page

            -   When reaching the bottom/top of a page, scrolling will stop, and the user will have to drag up/down to move to the next/previous chapter

                -   Similar to "pull-to-refresh" functionality

                -   Reference the app "Moon+ Reader" for an example of this behavior

        -   Via vertical/horizontal paging for each page

            -   Sections will not be separated by chapters

            -   Page breaks will exist to distinguish between chapters

            -   Users can navigate through the work by swiping left/right or up/down

        -   Via infinite vertical scrolling

            -   All chapters will be loaded into a single scrollable view

            -   Users can scroll through the entire work without having to navigate between chapters

    -   Users can bookmark chapters

        -   Bookmarks will be saved in the database

        -   Users can view a list of bookmarks for the current work

        -   Users can jump to a specific bookmark

    -   Users can highlight text in chapters

        -   Highlighting will be saved in the database

        -   Users can view a list of highlights for the current work

        -   Users can jump to a specific highlight

    -   Certain words/phrases will have a special indicator to indicate more information

        -   Similar to Kindle's "X-Ray" feature

        -   When the user taps on the indicator, a popup will appear with more information

            -   This will include:

                -   Definitions for words

                -   Character information for characters

                -   Event information for canonical events

            -   Users can tap on the indicator to view more information

            -   Users can tap on the "X-Ray" button to view all indicators in the current chapter

            -   Users can highlight a word/phrase to manually add it to the "X-Ray" list

                -   This will allow users to add custom indicators for words/phrases that are not already in the database

                -   Users can input custom descriptions for these indicators

                -   Users can also remove indicators from the "X-Ray" list

    -   Have a bottom configurable options bar with the options mentioned above

        -   Clicking the overflow button will show a sheet/dialog where the user can reorder the options and select which ones are visible in the options bar

    -   Users can search for text in the work

    -   Take a lot of design inspiration from Tachiyomi/Mihon's reader

        -   The reader will have a similar layout and functionality to the Tachiyomi/Mihon reader

        -   The reader will be designed to be responsive and work well on both phones and tablets

    -   Take some design inspiration from the "Moon+ Reader" application

        -   The reader will have a similar persistent progress bar at the bottom of the screen

            -   The progress bar will show the current chapter, total chapters, current position in the chapter, and progress through the work

        -   The reader will have a similar persistent options bar at the top of the screen

  

-   Download Queue

  

    -   A queue for downloading works and chapters

    -   Users can add works/chapters to the queue for downloading

    -   Will visually group chapters by work in a reorderable list

        -   The work group will itself be a reorderable list of chapters

    -   Users can reorder the queue to prioritize downloads

    -   Users can start, pause, and cancel downloads

    -   Downloads will be handled in the background

    -   Progress will be shown for each download

    -   If a download fails, it will be retried automatically

    -   If a download is paused, it can be resumed later

    -   If a download is canceled, it will be removed from the queue

    -   If a download is completed, it will be removed from the queue

    -   When a download is successfully completed, the metadata will be updated in the database and the file will be updated with the new content

        -   If a work is already in the database, the download will update the existing metadata and content

        -   If a work is not in the database, it will be added with the new metadata and content

    -   A persistent notifiaction will be shown while the download queue is active (more info in the Notifications section)

        -   This will allow users to see the progress of the downloads and access the download queue at any time

    -   The download queue shopuld persist across application restarts

        -   This will allow users to continue downloads even if the application is closed

        -   The queue will be saved in the database and restored when the application is started again

  

-   Notifications

  

    -   Persistent notification for the download queue

        -   Show the current progress with a progress bar

        -   Show the current item being downloaded

    -   Persistent notification for "Downloaded Only" mode

    -   Persistent notification for "Incognito Mode"

        -   This will allow users to know when they are in incognito mode and that their actions will not be saved

    -   Notifications for work updates

        -   Work updates will come from the background service that checks for updates

        -   More info in the Background Service section

    -   Notification for application updates

        -   Will be polled when the application is started, and periodically while the application is open

        -   If an update is available, a notification will be shown with the option to download and install the update

  

-   Accounts

  

    -   Users can add, remove, and edit accounts for sources

    -   Users can import favorites/bookmarks/subscriptions from their accounts on various sites

        -   AO3: Subscriptions, Bookmarks

        -   FFN: Favorited, Followed

    -   Users can add any works to their library from their accounts

        -   This will allow users to easily manage their library and keep track of their favorite works

    -   Users can configure account settings for each source

    -   Users can view their account information

        -   This will include:

            -   Username

            -   Email (if applicable)

            -   Account settings

    -   Account login credentials must be stored SECURELY, and cannot be backed up to the cloud

        -   This is to ensure user privacy and security

        -   The EXISTENCE of an account for various sites CAN be saved to the cloud, but the credentials themselves must not be saved

            -   This is to allow prompting the user to re-enter their credentials when restoring from a backup or moving to a new device

        -   Users will be able to log in to their accounts using their username/email and password

        -   Users will be able to log out of their accounts at any time

  

-   Background Service

  

    -   There must be a background service to periodically check for work updates, app updates, and perform other tasks

        -   This service will run in the background and will not require the application to be open

        -   The service will check for work updates based on the user's configured update frequency

        -   The service will check for application updates daily (if enabled in preferences) or when the application is open (unless explicitly disabled, a separate setting from periodic update checks)

    -   The service will also handle downloading works and chapters in the background

        -   This will allow users to continue using the application while downloads are in progress

        -   The service will handle the download queue and will update the database with the new metadata and content when a download is completed

  

-   3rd-Party Connection

    -   Fanfiction update notifications are typically sent to email addresses as a notification email

    -   I would like some way to possibly hook in to an email account to send a push notification to the application when an applicable email is received

        -   This would require the user to grant permission to access their email account

        -   The application would need to securely store the user's email credentials

        -   The email service would send some notification or run some sort of cloud function when an email from a configured sender is received

            -   AO3: do-not-reply@archiveofourown.org

            -   FFN: bot@fanfiction.com

        -   Possibly use a service like IFTTT or Zapier to connect the email account to the application

            -   This would allow the application to receive notifications when an email is received from a configured sender

            -   The application would need to handle the notification and display it to the user

        -   Possibly use a Google email address and use the Gamil API and/or Firebase Cloud Functions to check for new emails

            -   This would allow the application to receive notifications when an email is received from a configured sender

            -   The application would need to handle the notification and display it to the user

        -   Possibly use a service like Firebase Cloud Messaging to send push notifications to the application when an email is received

            -   This would allow the application to receive notifications even when it is not running

            -   The application would need to handle the notification and display it to the user

  

I have a limited amount of time before I would like for the first version of the application to be functional (about a week), so I would like to prioritize the most important features and functionality first. The application is currently in a state where it can be used to read works (from the database stored content, NOT from files), so I would like to focus on refining the codebase and implementing the features that will allow users to manage their library of works effectively.

  

Given the previous information, I would like to ask for your help in the following areas:

  

-   Refactoring the codebase to simplify and improve the structure

-   Converting my existing approach to storing only metadata in the database while keeping the actual content in eBook files

-   Determining a plan of action for implementing the features and functionality described above

-   Providing guidance on best practices for implementing the features and functionality