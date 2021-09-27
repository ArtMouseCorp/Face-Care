import UIKit

class LoadingViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        fetchData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            if State.shared.isFirstLaunch() {
                
                let startViewController = StartViewController.load(from: Screen.start)
                startViewController.modalPresentationStyle = .fullScreen
                self.present(startViewController, animated: false)
                
            } else {
                
                let tabBar = TabBarController.load(from: Screen.tabBar)
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true)
                
            }
            
        }
    }
    
    // MARK: - Custom functions
    
    private func fetchData() {
        
        Article.getAll()
        
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
