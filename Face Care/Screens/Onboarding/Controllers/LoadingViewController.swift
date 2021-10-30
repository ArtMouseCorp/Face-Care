import UIKit

class LoadingViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var progressBarView: UIView!
    
    // MARK: - Variables
    
    let LOADING_DURATION: Double = 2
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        checkIfLastTrainingCompleted()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        State.shared.setCurrentScreen(to: "Loading Screen")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + LOADING_DURATION) {
            
            StoreManager.updateStatus()
            
            if State.shared.isFirstLaunch() || !State.shared.isOnboardingCompleted() {

                let startViewController = StartViewController.load(from: Screen.start)
                startViewController.modalPresentationStyle = .fullScreen
                self.present(startViewController, animated: false)
                return

            }
            
            let tabBar = TabBarController.load(from: Screen.tabBar)
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true)

        }
    }
    
    // MARK: - Custom functions
    
    private func startLoading() {
        
        progressBarView.capsuleCorners()
        progressBarView.backgroundColor = UIColor(red: 0.304, green: 0.3, blue: 0.75, alpha: 1)
        
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 0, width: 0, height: progressBarView.frame.height)
        
        view.backgroundColor = .FCWhite
        view.capsuleCorners()
        
        progressBarView.addSubview(view)
        
        UIView.animate(withDuration: LOADING_DURATION) {
            view.frame.size.width = self.progressBarView.frame.width
        }
        
    }
    
    private func fetchData() {
        
        Article.getAll()
        FaceArea.getAll()
        Offer.get()
        
        StoreManager.updateStatus()
        
        if !State.shared.isFirstLaunch() && State.shared.isOnboardingCompleted() {
            Training.Daily.loadFromJson()
            Training.Exclusive.loadFromJson()
        }
        
    }
    
    private func checkIfLastTrainingCompleted() {
        
        if State.shared.getOpenedDailyTrainingNumber() == 8 && isNextTrainingShouldBeOpen() {
            Training.Daily.createTrainings()
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
