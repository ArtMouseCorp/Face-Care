import UIKit
import PanModal

class ExercisePopupViewController: BasePopupViewController {

    // MARK: - @IBOutlets
    
    // MARK: - Variables
    
    // Views
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var startTrainingButton: FCButton!
    
    // Image Views
    // ...
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setPopupHeight(328)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        startTrainingButton.configure(as: .filled)
    }
    
    // MARK: - @IBActions
    @IBAction func startTrainingButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
