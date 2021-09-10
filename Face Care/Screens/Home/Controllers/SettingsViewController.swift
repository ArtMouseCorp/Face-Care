import UIKit

class SettingsViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // MARK: - Variables
    
    // Views
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contactusLabel: UILabel!
    @IBOutlet weak var refreshSubscriptionLabel: UILabel!
    
    // Buttons
    
    // Table Views
    @IBOutlet weak var tableView: UITableView!
    
    // Constraints
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
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
