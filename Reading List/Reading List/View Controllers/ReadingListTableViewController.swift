
import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

    

    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sectionCount = 0
        if section == 0 {
            sectionCount = bookController.readBooks.count
        } else if section == 1 {
            sectionCount = bookController.unreadBooks.count
        }
        return sectionCount
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
        bookController.updateHasBeenRead(book: <#T##Book#>)
        tableView.reloadData()
    }
    
}
