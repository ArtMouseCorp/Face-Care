import UIKit

class ExerciseViewController: BaseViewController {

    // MARK: - @IBOutlets
        
    // Views
    @IBOutlet weak var circleVideoProgressView: UIView!
    @IBOutlet weak var currentProgressView: UIView!
    @IBOutlet weak var allProgressView: UIView!
    
    // Labels
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    
    // Image Views
    @IBOutlet weak var mainImageView: UIImageView!
    
    // Stack views
    @IBOutlet weak var linesStackView: UIStackView!
    
    // MARK: - Variables
    
    var onDismiss: (() -> ()) = {}
    
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
        for view in linesStackView.subviews {
            view.capsuleCorners()
        }
        circleVideoProgressView.capsuleCorners()
        currentProgressView.capsuleCorners()
        allProgressView.capsuleCorners()
    }
    
    private func configureOnPopup(isHidden: Bool = true) {
        linesStackView.isHidden = !isHidden
        closeButton.isHidden = !isHidden
        exerciseNameLabel.isHidden = !isHidden
    }
    
    private func setupGestures() {
        
        // TODO: - Change imageView to videoView
        
        mainImageView.addTapGesture(target: self, action: #selector(pauseVideo))
    }
    
    // MARK: - Gesture actions
    
    @objc private func pauseVideo() {
        
        // TODO: - Pause plaing video
        
        let infoPopup = ExerciseInfoPopup.load(from: Popup.exerciseInfo)
        self.presentPanModal(infoPopup)
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        // TODO: - Pause video
        
        let alert = UIAlertController(title: "Вы уверены, что хотите выйти?", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Да", style: .default) { _ in
            
            // TODO: - Pause video & go to home page
            
//            let tabBar = TabBarController.load(from: Screen.tabBar)
//            tabBar.modalPresentationStyle = .fullScreen
//            self.present(tabBar, animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { _ in
            // TODO: - Play video
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
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
