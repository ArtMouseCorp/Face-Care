import UIKit

class PlanGenerationViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var progressBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var processLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Variables
    
    var progressTimer: Timer = Timer()
    var currentPage: Int = 0
    var currentProgress: Int = 0
    
    var progressView: UIView = UIView()
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timerStart()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        imageView.whiteGradient(locations: [0.55, 1], opacity: 1)
        progressBackgroundView.capsuleCorners()
        
        progressView.frame = CGRect(x: 0, y: 0, width: 0, height: progressBackgroundView.frame.height)
        progressView.capsuleCorners()
        progressBackgroundView.addSubview(progressView)
        
        updatePageContent()
    }
    
    private func localize() {
        titleLabel.localize(with: L.PlanGeneration.title)
    }
    
    private func fetchData() {
        
        Training.Daily.createTrainings()
        Training.Exclusive.createTrainings()
        
    }
    
    private func updatePageContent() {
        
        progressView.frame.size.width = 0
        
        switch currentPage {
            
        case 0:
            
            imageView.image = .FCPlanGeneration1
            processLabel.localize(with: L.PlanGeneration.first)
            progressView.backgroundColor = .FCSalmon
            
            State.shared.setCurrentScreen(to: "Plan Generation: First Screen")
            
        case 1:
            
            imageView.image = .FCPlanGeneration2
            processLabel.localize(with: L.PlanGeneration.second)
            progressView.backgroundColor = .FCVeryLightTangelo
            
            State.shared.setCurrentScreen(to: "Plan Generation: Second Screen")
            
        case 2:
            
            imageView.image = .FCPlanGeneration3
            processLabel.localize(with: L.PlanGeneration.third)
            progressView.backgroundColor = .FCAlienArmpit
            
            State.shared.setCurrentScreen(to: "Plan Generation: Third Screen")
            
        default:
            break
            
        }
        
    }
    
    private func timerStart() {
        
        UIView.animate(withDuration: 4) {
            self.progressView.frame.size.width = UIScreen.main.bounds.width - 32
        }
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.04,
                                             target: self,
                                             selector: #selector(updateProgressView),
                                             userInfo: nil, repeats: true)
        
    }
    
    @objc func updateProgressView() {
        
        if currentProgress == 100 {
            
            progressTimer.invalidate()
            
            if currentPage == 2 {
                
                let tabBar = TabBarController.load(from: Screen.tabBar)
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true)
                
                return
            }
            
            currentPage += 1
            updatePageContent()
            currentProgress = 0
            timerStart()
            
        }
        
        percentLabel.text = "\(currentProgress)%"
        currentProgress += 1
        
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
