import UIKit

class LoadingViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let startViewController = StartViewController.load(from: Screen.start)
            startViewController.modalPresentationStyle = .fullScreen
            self.present(startViewController, animated: false, completion: nil)
        }
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
