import UIKit

class ProgressSettingsViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // MARK: - Variables
    
    // Views
    @IBOutlet weak var mainView: UIView!
    
    // Labels
    @IBOutlet weak var mainLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var resetProgressButton: FCButton!
    // Image Views
    // ...
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        mainView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        resetProgressButton.configure(as: .filled)
    }
    
    private func setupGestures() {
        
    }
    
    // MARK: - Gesture actions
    
    // MARK: - @IBActions
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
