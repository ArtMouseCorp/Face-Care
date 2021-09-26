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
    var onCloseCompletion: ((_ currentItem: Int)->()) = {_  in }
    var currentItem = 0
    var exercisePack: [Exercise] = []
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        titleLabel.text = exercisePack[currentItem].name
        descriptionLabel.text = exercisePack[currentItem].description
        
        checkChevrons()
        
        descriptionLabelHeightConstraint.constant = descriptionLabel.contentHeight(lineSpacing: 4)
        super.setPopupHeight(popupHeight + descriptionLabelHeightConstraint.constant)
        super.panModalSetNeedsLayoutUpdate()
        
        nextButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    private func checkChevrons() {
        prevButton.isHidden = currentItem == 0
        nextButton.isHidden = currentItem == exercisePack.count - 1
    }
    
    override func panModalDidDismiss() {
        onCloseCompletion(currentItem)
    }
    
    // MARK: - @IBActions
    
    @IBAction func prevButtonPressed(_ sender: Any) {
        currentItem -= 1
        configureUI()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        currentItem += 1
        configureUI()
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
