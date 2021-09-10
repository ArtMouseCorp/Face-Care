import UIKit

class ImagePopup: UIViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    // Buttons
    
    // Image Views
    @IBOutlet weak var imageView: UIImageView!
    
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
        mainView.layer.cornerRadius = 28
        backgroundView.layer.cornerRadius = 28
        backgroundView.backgroundColor = UIColor(red: 218/255, green: 212/255, blue: 226/255, alpha: 1)
        imageView.layer.cornerRadius = 28
    }
    
    private func setupGestures() {
        
    }
    
    // MARK: - Gesture actions
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
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
