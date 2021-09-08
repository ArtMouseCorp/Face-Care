import UIKit

class ExerciseTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cellBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var exerciseImageView: UIImageView!

    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        cellBackgroundView.roundCorners(radius: 8, corners: .allCorners)
        
        cellBackgroundView.layer.shadowColor = UIColor.FCBlack.withAlphaComponent(0.2).cgColor
        cellBackgroundView.layer.shadowOpacity = 1
        cellBackgroundView.layer.shadowRadius = 10
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let gradient = CAGradientLayer()
        
        gradient.frame = exerciseImageView.frame

        gradient.colors = [
            UIColor.FCWhite.withAlphaComponent(0).cgColor,
            UIColor.FCWhite.withAlphaComponent(0.3).cgColor
        ]
        
        gradient.locations = [0, 1]
        gradient.opacity = 0.3
        
        exerciseImageView.layer.addSublayer(gradient)
        
    }
    
    public func configure(name: String, description: String, image: UIImage) {
        
        nameLabel.text = name
        descriptionLabel.text = description
        exerciseImageView.image = image
        
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
