import UIKit

class ExclusiveTrainingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cellBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var trainingImageView: UIImageView!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.contentView.clipsToBounds = false
        self.contentView.layer.masksToBounds = false
        
        cellBackgroundView.roundCorners(radius: 8, corners: .allCorners)
        
        cellBackgroundView.layer.shadowColor = UIColor.FCBlack.withAlphaComponent(0.2).cgColor
        cellBackgroundView.layer.shadowOpacity = 1
        cellBackgroundView.layer.shadowRadius = 10
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        trainingImageView.roundCorners(radius: 8, corners: .topLeft, .topRight)
        
//        trainingImageView.whiteGradient(locations: [0, 1], opacity: 0.3)
        
        let gradient = CAGradientLayer()
        
        gradient.frame = trainingImageView.frame

        gradient.colors = [
            UIColor.FCWhite.withAlphaComponent(0).cgColor,
            UIColor.FCWhite.withAlphaComponent(1).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.opacity = 0.3
        trainingImageView.layer.addSublayer(gradient)
        
    }
    
    public func configure(name: String, duration: String, image: UIImage) {
        
        nameLabel.text = name
        durationLabel.text = duration
        trainingImageView.image = image
        
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
