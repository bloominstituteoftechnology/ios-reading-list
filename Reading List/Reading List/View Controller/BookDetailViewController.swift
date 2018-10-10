import UIKit

class BookDetailViewController: UIViewController {

    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var reasonToRead: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        if let book = book {
            self.title = book.title
            bookTitle?.text = book.title
            reasonToRead?.text = book.reasonToRead
        } else {
            self.title = "Add a new book"
        }
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = bookTitle.text,
            let reasonToRead = reasonToRead.text else { return }
        
        if let book = book {
            bookController?.updateBook(for: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.create(title: title, reasonToRead: reasonToRead)
        }
        
        bookController?.loadFromPersistentStore()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Properties
    
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
}
