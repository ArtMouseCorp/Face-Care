import UIKit

class ExerciseLoadingViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        loadVideo()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
    }
    
    private func loadVideo() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let exerciseVC = ExerciseViewController.load(from: Screen.exercise)
            exerciseVC.modalPresentationStyle = .fullScreen
            exerciseVC.modalTransitionStyle = .crossDissolve
            self.present(exerciseVC, animated: false)
        }
        
    }
    
    // MARK: - @IBActions
    
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
