//
//  CommitNotes.swift
//  Reading List
//
//  Created by Harm on 3/4/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import Foundation

/*
 
 // MARK: - WIP
 
 
 
 // MARK: - To do
 Go further
 
 // MARK: - Done
 Part 1 Book and BookController
    Book
        1. Create a "Book.swift" file
        2. Create a struct "Book" that has a title string, a reasonToRead string, and  hasBeenRead bool
        3. Create initializer for struct, default value of false to hasBeenRead
        4. Adopt Equatable and Codable protocols
    BookController
        1. Create a "BookController.swift" file
        2. Create a BookController class with the variable books set to an empty array of Book objects
        3. Create computed property called "readingListURL: URL?" and inside:
            Get user's document directory using FileManager class
            Create filename string for plist such as "ReadingList.plist"
            Return URL appending the filename string to the document directory
        4.Create a function saveToPersistentStore() and inside:
            Create an instance of PropertyListEncoder
            Inside a do-try-catch block, create a constant booksData
            Encode the books array into Data using encode(value: ...) function of the property list encoder, encode the books array into Data.
            Call the write(to: URL) function on the data you encoded computed property, URL passed in should be unwrapped version of readingListURL
        5. Create a function loadFromPersistentStore
            Inside a do-try-catch block, unwrap the readingListURL
            Inside the same block, use Data(contentsOf: URL) init to get access to property list form of the books and assign this data to a constant
            Initialize a PropertyListDecoder and assign it to a constant
            Create a constant decodedBooks and set value by calling the decode method on the decoder
            Set the value of books property in BookController to decodedBooks
            In the catch block, make an error message
        6. Make CRUD methods (call saveToPersistentStore() at the end of each)
            "Create" method that inits a new Book object
            "Delete" method that passes in a Book object as a parameter and removes it from books
            "Update" method "updateHasBeenRead(for book: Book)", change the hasBeenRead value
            "Update" method "updateReasonOrTitle(for book: Book)", swap old title/reason properties with new Strings
        7. "readBooks: [Book]" computed property that returns an array of all Book objects in books whose hasBeenRead property is true
        8. "unreadBooks: [Book]" computed property that returns an array of all Book objects in books whose hasBeenRead property is false
 Part 2 Storyboard Scenes
    1. Add scenes
        Embed UITableViewController into navigation controller
        Set navigation controller as initial view controller
        Add a UIViewController
    2. Set the table view controller's title to "Reading List"
    3. In the table view's cell:
        Set its style to "Custom"
        Add a label (the title of the book)
        Add a button and remove its title (checked or unchecked box for read or unread status) and set its aspect ratio to 1:1
        Constrain these UI elements to the cell's content view (stack view or individually)
        Create a show segue from the cell to the detail view controller and give the segue an identifier
    4. Add a bar button item in the top-right corner of the table view controller
        Set its "System Item" to "Add"
        Create a segue from the bar button item to the detail view controller and give it an identifier
    5. Create a Cocoa Touch subclass for both the table view controller and the custom UITableViewCell
        Call the UITableViewController subclass "ReadingListTableViewController"
        Call the UITableViewCells subclass "BookTableViewCell"
        Set the table view controller and the cell's class in the Identity Inspector
    6. In the custom cell class
        Create an outlet from the label
        Create an outlet and an action from the button
    7. Add a text field (title of book) and a text view (reason to read) to the detail view controller scene and constrain (with keyboard in mind)
    8. Add navigation item to the detail view controller, and add a "Save" system item bar button item to the top-right corner of the view controller
    9. Create a Cocoa Touch subclass of UIViewController called "BookDetailViewController" and set it to the class of the view controller
    10. Add outlets from the text field and text view, and an action from the save button
 Part 3 Wiring Everything Up
    BookTableViewCell
        1. Add a var book: Book? variable to the BookTableViewCell class
        2. Create an updateViews() function that takes the values in the book property and sets its title in the label, and set the button's image to either the checked or unchecked image in the assets folder (using image literals or UIImage(named: String))
        3. Create a new swift file called "BookTableViewCellDelegate.swift" and create a protocol with the same name
        4. Add a function called "func toggleHasBeenRead(for cell: BookTableViewCell)"
        5. In BookTableViewCell, add a weak var delegate: BookTableViewCellDelegate?
        6. Call the delegate property's toggleHasBeenRead(...) func in the action of the button
    ReadingListTableViewController
        1. Add a bookController constant, and set its value to a new instance of BookController
        2. Implement numberOfSections(in tableView: ...) and return 2
        3. Implement numberOfRowsInSection and use readBooks and unreadBook to calculate rows having the first section (0) show read, and second section (1) show unread
        4. Write a function "bookFor(indexPath: IndexPath) -> Book" that will return the right book using indexPath.row book of indexPath.section
        5. Adopt BookTableViewCellDelegate protocol and add toggleHasBeenRead(for cell: ...) function that calls the BookController's updateHasBeenRead(for: Book) method then reload the tableView (get an IndexPath using cell parameter to get an instance of Book to pass into the function)
        6. Fill out the cellForRowAt function and set the cell's delegate property
        7. Fill out the "commit editingStyle" function, only worry about the .delete case
        8. Fill out the titleForHeaderInSection function, giving each section a unique title
    BookDetailViewController
        1. Add an optional book controller variable
        2. add an optional book variable
        3. create an updateViews() method. If the book variable has a value, take its title and put it in the text field, and put its reasonToRead in the textView, and set the title of the view controller to the book's title if there is one, or set the title to "Add a new book" if a new book is going to be created
        4. In the action of the button, either call the createBook function in bookController if the book property is nil, or the update method in the bookController if the book property is not nil
    ReadingListTableViewController
        1. Check the segue's identifier:
            If it's the "Add" bar button, that means the user wants to create a new book, pass the bookController in the table view controller to the segue's destination view controller (cast the destination as the correctly typed view controller)
            If it's the cell's identifier, do the same and also pass a Book object that was selected in the table view to the destination view controller's book property
 
*/
