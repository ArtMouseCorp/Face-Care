import UIKit

class LanguageTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var nameLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with language: Language, selected: Bool) {
        nameLabel.text = language.name
        nameLabel.font = .ralewayFont(ofSize: 18, weight: selected ? .bold : .regular)
        flagImageView.image = language.image
        checkmarkImageView.isHidden = !selected
    }

}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
