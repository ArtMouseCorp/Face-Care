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
    
    override func viewWillAppear(_ animated: Bool) {
        State.shared.setCurrentScreen(to: "Loading Screen")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            if State.shared.isFirstLaunch() || !State.shared.isOnboardingCompleted() {

                let startViewController = StartViewController.load(from: Screen.start)
                startViewController.modalPresentationStyle = .fullScreen
                self.present(startViewController, animated: false)
                return

            }
            
            if State.shared.isOnboardingCompleted() && !State.shared.isSubscribed {
                let photoOfferVC = PhotoOfferViewController.load(from: Screen.photoOffer)
                photoOfferVC.modalPresentationStyle = .fullScreen
                photoOfferVC.page = 2
                self.present(photoOfferVC, animated: true)
                return
            }

            let tabBar = TabBarController.load(from: Screen.tabBar)
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true)

        }
    }
    
    // MARK: - Custom functions
    
    private func fetchData() {
        
        Article.getAll()
        FaceArea.getAll()
        Offer.get()
        
        if !State.shared.isFirstLaunch() && State.shared.isOnboardingCompleted() {
            Training.Daily.getTrainings()
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
