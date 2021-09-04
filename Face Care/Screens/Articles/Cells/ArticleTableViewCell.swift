import UIKit

class ArticleTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cellBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var articleImageView: UIImageView!

    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        cellBackgroundView.roundCorners(radius: 16, corners: .allCorners)
        cellBackgroundView.clipsToBounds = true
    }
    
    public func initialize(title: String, image: UIImage?) {
        articleTitleLabel.text = title
        articleImageView.image = image
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
