import UIKit

class ProgressDemoPopup: UIViewController {

    // MARK: - @IBOutlets
    
    // Views
    // Labels
    // Buttons
    // Image Views
    // ...

    // MARK: - Variables
    
    var onPopupClose: (()->()) = {}
    
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
        self.view.addTapGesture(target: self, action: #selector(close))
    }
    
    // MARK: - Gesture actions
    
    @objc private func close() {
        onPopupClose()
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
