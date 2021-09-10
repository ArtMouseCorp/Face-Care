import UIKit

class PhotoOfferViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // MARK: - Variables
        
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var makePhotoButton: FCButton!
    @IBOutlet weak var skipButton: UIButton!
    
    // Image Views
    @IBOutlet weak var mainImageView: UIImageView!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        makePhotoButton.configure(as: .filled)
    }
        
    // MARK: - @IBActions
    @IBAction func makePhotoButtonPressed(_ sender: Any) {
        
        let planGeneration = PlanGenerationViewController.load(from: Screen.planGeneration)
        planGeneration.modalPresentationStyle = .fullScreen
        self.present(planGeneration, animated: true)
        
//        let tabBar = TabBarController.load(from: Screen.tabBar)
//        tabBar.modalPresentationStyle = .fullScreen
//        self.present(tabBar, animated: true, completion: nil)
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        let planGeneration = PlanGenerationViewController.load(from: Screen.planGeneration)
        planGeneration.modalPresentationStyle = .fullScreen
        self.present(planGeneration, animated: true)
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
