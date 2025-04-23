given the attached codebase, how do I write a ReaderScreen activity that will allow me to:

-   Have the 1st page be a title/fandom(s)/author(s) page
-   Have the 2nd page be a page with additional work info (characters, relationships, tags, etc.)
-   Have subsequent pages be the actual content of the work, with the ability to page between chapters, and each chapter be scrollable until the end
    -   i.e. the user PAGES from the 2nd screen to the 1st chapter, which is SCROLLABLE and takes up as much space as it needs to, until it reaches the end, and the user must PAGE to the next chapter
    -   All scrolling/paging must have the ability to be vertical (see Moon+ Reader for example)
    -   If a chapter has not been downloaded when trying to navigate to it, download the next chapter if able
    -   Paging between chapters might show a small circular progress indicator at the bottom of the screen (again, using Moon+ Reader as an example)
-   Keep track of read progress (and update the work in the database)
-   Have subsequent navigations to this activity go straight to the last read position (unless navigating via one of the following):
    -   Have clicks on the individual chapter widgets navigate straight to the associated chapter
    -   Have clicks on the LibraryComponentItem's Play button continue reading from the last read position (if it exists, otherwise start from the beginning)
    -   Have a side drawer with the table of contents (where tapping on an entry will navigate directly to the associated chapter)
-   Have the progress bar of the LibraryComponentItem show the read progress
-   Have the activity be fullscreen until the user clicks on the screen, which toggles the application between edgeToEdge and immersiveSticky
-   The volume buttons should be able to navigate to the next/previous page

Chapter content is defined as a string of HTML text that contains the following, in order:

-   Chapter Title
-   Chapter Summary (if it exists)
-   Chapter Start Notes (if there are any)
-   Chapter Content
-   Chapter End Notes (if there are any)

Also, ideally the application will be able to detect line breaks (long strings of '-' or '=', as an example) and modify them to only take up the width of the screen, so they have no wraparound
