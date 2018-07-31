import Foundation
import UIKit

class BookListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, BookCellDelegate
{
	var controller:BookController = BookController()

	@IBOutlet weak var table: UITableView!

	func onToggle(_ book: Book, state: Bool)
	{
		controller.markRead(book, state:state)
		table.reloadSections(IndexSet(0...1), with: .fade);
	}

	override func viewDidLoad()
	{
		table.dataSource = self
		table.delegate = self
	}

	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)

		controller.sortBooks()
		table.reloadData()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if section == 0 {
			return controller.unreadBooks.count
		} else if section == 1 {
			return controller.readBooks.count
		}
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let defaultCell = tableView.dequeueReusableCell(withIdentifier: "BookCell")
		guard let cell = defaultCell as? BookCell else { return defaultCell!}
		cell.delegate = self
		if indexPath.section == 0 {
			cell.book = controller.unreadBooks[indexPath.row]
		} else if indexPath.section == 1 {
			cell.book = controller.readBooks[indexPath.row]
		}
		return cell
	}

	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 2
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
	{
		return ["Unread", "Read"][section]
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
	{
		return true
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
	{
		if editingStyle == .delete {
			var books = indexPath.section == 0 ? controller.unreadBooks : controller.readBooks
			controller.delete(books[indexPath.row])
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}

	override  func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if let dest = segue.destination as? AddBookVC {
			dest.controller = controller
			if let sender = sender as? BookCell {
				dest.book = sender.book
			}
		}
	}
	
}

