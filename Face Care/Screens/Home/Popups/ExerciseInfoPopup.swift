import UIKit
import PanModal

class ExerciseInfoPopup: BasePopupViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // Constraints
    @IBOutlet weak var descriptionLabelHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var popupHeight: CGFloat = 24 + 32 + 24 + 0 + 24 // without descriptionLabel height
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        descriptionLabelHeightConstraint.constant = descriptionLabel.contentHeight(lineSpacing: 4)
        super.setPopupHeight(popupHeight + descriptionLabelHeightConstraint.constant)
        super.panModalSetNeedsLayoutUpdate()
        
        nextButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    // MARK: - @IBActions
    
    @IBAction func prevButtonPressed(_ sender: Any) {
        // TODO: - Open previous exercise
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        // TODO: - Open next exercise
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
