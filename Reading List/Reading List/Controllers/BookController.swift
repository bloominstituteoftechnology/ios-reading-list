//
//  BookController.swift
//  Reading List
//
//  Created by Angel Buenrostro on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//
/* BookController

Up until now, the model controllers you've made have been more or less the same, where they just have CRUD methods, and an array of your model object. Now however since you will be implementing a form of persistence, the model controller gets another responsibility which is to make sure that when a Book changes (whether by creating a new one, deleting once, or changing one), those changes are saved and persisted. It would be weird if the user deletes a Book, then the next time they open the app, the book is magically there again.

Let's prepare the BookController to handle saving and loading from the persistent store. First of all, Codable is the main driving force behind this form of persistence. It allows us to convert Book objects to Property-List form and back to Books. We need a place to save this property list on the device's hard drive.
    
 

Create a function called loadFromPersistentStore(). This function will be responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc. To implement this:
Inside of a do-try-catch- block, unwrap the readingListURL property.
Still inside of the block, use the Data(contentsOf: URL) initializer to get access to the property list form of the books. Assign this data you initialize to a constant.
Initialize a PropertyListDecoder and assign it to a constant.
Create a constant called decodedBooks. Set its value by calling the decode method on the property list decoder you just created, and passing in the type it should be decoded as, and the data constant you made a couple steps ago. (Hint: the type parameter to this function should be [Book].self)
Set the value of the books property in the BookController to the decodedBooks you just made.
In the catch block, you should make an error message that is descriptive of what happened

Like always, we will need to make CRUD methods. As we're using a form of persistence, be sure to call saveToPersistentStore() at the end of each of these or the changes will not persist:
Add a "Create" method that initializes a new Book object. In order to persist the newly created Book, call the saveToPersistentStore() method at the end of this function.
Add a "Delete" method that passes in a Book object as a parameter, and removes it from the books array.
We'll need two "Update" methods:
One is to update a Book object's hasBeenRead property. Call it updateHasBeenRead(for book: Book). It should simply swap the hasBeenRead value from false to true and vice-versa.
The other is to edit the Book's title and/or reasonToRead properties.

You may have noticed from the screen recording that the table view is going to have more than one section. In order to facilitate the implementation of this multi-section table view, we're going to add a couple computed properties to the BookController:

Create a computed property called readBooks: [Book]. Inside of the closure of the computed property, you will need to return an array of all of the Book objects from the books array whose hasBeenRead property is true. The easiest way to do that is by using the .filter higher-order function. If you are unfamiliar with this function, read the part of this article titled "Filter". If you still have questions, please ask in the help channel for your cohort, and a PM will explain it to you in more depth.
Create a similar computed property called unreadBooks: [Book] that does the same thing, except it returns an array of Books whose hasBeenRead property is false.
*/

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        // Users/Angel/Documents
        let finalLocation = documentsDirectory.appendingPathComponent("ReadingList.plist")
        return finalLocation
    }
    
    
    func saveToPersistentStore(){
        guard let url = readingListURL else { return } // ensuring there is a valid save destination
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch{
            print(error)
        }
    }
    
    func loadFromPersistentStore(){
        
        do{
            guard let url = readingListURL else { return }
            
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print ("no url or no data at url")}
    }
    
    func Create(title: String, reason : String){
        let newBook = Book(title: title, reasonToRead: reason, hasBeenRead: false)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func Delete(bookToDelete : Book){
        var index = 0
        while index < books.count {
            if bookToDelete == books[index]{
                books.remove(at: index)
                return
            }
            index += 1
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book){
        var index = 0
        while index < books.count {
            if books[index] == book{
                let oldBook = books[index]
                let oldBookTitle = oldBook.title
                let oldBookReason = oldBook.reasonToRead
                let oldBookRead = oldBook.hasBeenRead
                books.remove(at: index)
                let newBook = Book(title: oldBookTitle, reasonToRead: oldBookReason, hasBeenRead: !oldBookRead)
                books.insert(newBook, at: index)
            }
            index += 1
        }
        saveToPersistentStore()
    }
    
    
    func updateTitleOrReason(for book: Book, newTitle title: String?, newReason reason: String?){
        var index = 0
        while index < books.count {
            if books[index] == book {
                let oldBookTitle = books[index].title
                let oldBookReason = books[index].reasonToRead
                let oldBookRead = books[index].hasBeenRead
                books.remove(at: index)
                if title != nil && reason != nil {
                    let updatedBook = Book(title: title!, reasonToRead: reason!, hasBeenRead: oldBookRead)
                    books.insert(updatedBook, at: index)
                    saveToPersistentStore()
                    return
                } else if title != nil {
                    let updatedBook = Book(title: title!, reasonToRead: oldBookReason, hasBeenRead: oldBookRead)
                    books.insert(updatedBook, at: index)
                    saveToPersistentStore()
                    return
                } else if reason != nil {
                    let updatedBook = Book(title: oldBookTitle, reasonToRead: reason!, hasBeenRead: oldBookRead)
                    books.insert(updatedBook, at: index)
                    saveToPersistentStore()
                    return
                }
            }
            index += 1
        }
        saveToPersistentStore()
    }
    
    
    var readBooks: [Book] {
        var allReadBooks : [Book] = []
        allReadBooks = books.filter { $0.hasBeenRead == true }
        return allReadBooks
    }
    
    var unReadBooks: [Book] {
        var allUnreadBooks: [Book] = []
        allUnreadBooks = books.filter { $0.hasBeenRead == false }
        return allUnreadBooks
    }
    
}



