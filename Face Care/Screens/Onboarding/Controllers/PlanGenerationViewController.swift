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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timerStart()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        imageView.whiteGradient(locations: [0.55, 1], opacity: 1)
        progressBackgroundView.capsuleCorners(corners: .allCorners)
        
        progressView.frame = CGRect(x: 0, y: 0, width: progressBackgroundView.frame.width, height: progressBackgroundView.frame.height)
        progressBackgroundView.addSubview(progressView)
        
        updatePageContent()
    }
    
    private func updatePageContent() {
        
//        progressView.frame.size.width = 0
        
        switch currentPage {
            
        case 0:
            
            imageView.image = .FCPlanGeneration1
            processLabel.text = "Анализ проблемных зон"
            progressView.backgroundColor = .FCSalmon
            
        case 1:
            
            imageView.image = .FCPlanGeneration2
            processLabel.text = "Анализ состояния кожи"
            progressView.backgroundColor = .FCVeryLightTangelo
            
        case 2:
            
            imageView.image = .FCPlanGeneration3
            processLabel.text = "Подбор упражнений для лица согласно твоим потребностям"
            progressView.backgroundColor = .FCAlienArmpit
            
        default:
            break
            
        }
        
    }
    
    private func timerStart() {
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.05,
                                             target: self,
                                             selector: #selector(updateProgressView),
                                             userInfo: nil, repeats: true)
        
    }
    
    @objc func updateProgressView() {
        
        if currentProgress == 100 {
            
            progressTimer.invalidate()
            
            guard currentPage < 3 else {
                let tabBar = TabBarController.load(from: Screen.tabBar)
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true)
                return
            }
            
            currentPage += 1
            updatePageContent()
            currentProgress = 0
            timerStart()
            
        } else {
            
//            progressView.frame.size.width += 1 / progressBackgroundView.frame.width
            
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
