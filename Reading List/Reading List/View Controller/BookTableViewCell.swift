import UIKit

class BookTableViewCell: UITableViewCell {

    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var hasBeenReadButtonLabel: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    private func updateViews() {
        guard let book = book else { return }
        bookTitle.text = book.title
        book.hasBeenRead == true
            ? hasBeenReadButtonLabel.setImage(UIImage(named: "checked"), for: .normal)
            : hasBeenReadButtonLabel.setImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    // MARK: - Methods
    
    @IBAction func selectHasBeenRead(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
