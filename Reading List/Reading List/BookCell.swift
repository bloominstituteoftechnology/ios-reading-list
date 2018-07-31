import Foundation
import UIKit

protocol BookCellDelegate: class
{
	func onToggle(_ book:Book, state:Bool)
}

class BookCell: UITableViewCell
{
	weak var delegate:BookCellDelegate!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var readButton: UIButton!
	var book:Book! {
		didSet {
			nameLabel.text = book.name
			readButton.setImage(getButtonImage(), for: UIControlState.normal)
		}
	}

	@IBAction func readToggled(_ sender: Any)
	{
		book.read = !book.read
		readButton.setImage(getButtonImage(), for: UIControlState.normal)
		delegate?.onToggle(book, state:book.read)
	}

	func getButtonImage() -> UIImage!
	{
		return book.read ? UIImage(named: "checked") : UIImage(named:"unchecked")
	}

}
