import UIKit
import AVFoundation

class PhotoOfferViewController: BaseViewController {

    // MARK: - @IBOutlets
            
    // Views
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet var dotViews: [UIView]!
    @IBOutlet weak var continueButtonView: UIView!
    @IBOutlet weak var outlineView: UIView!
    
    // Labels
    @IBOutlet weak var outlineTitleLabel: UILabel!
    @IBOutlet weak var outlineViewLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    // Image Views
    @IBOutlet weak var faceImage: UIImageView!
    
    // Buttons
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // Stack Views
    @IBOutlet weak var starStackView: UIStackView!
    
    // MARK: - Variables
    
    // Player
    var playerLayer: AVPlayerLayer!
    fileprivate var playerObserver: Any?
    fileprivate var player: AVPlayer? {
        didSet { player?.play() }
    }
    deinit {
        guard let observer = playerObserver else { return }
        NotificationCenter.default.removeObserver(observer)
    }
    
    // Other
    var isSubviewed = false
    var isToggleOn = true
    var page = 0
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVideo()
        playerLayer.frame = self.view.layer.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resize
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        configureGradientView()
        configureButtons()
        configureDotViews(firstToHide: 2, secondToHide: 4)
        configureOutlineView()
        
        commentLabel.isHidden = true
        starStackView.isHidden = true
        outlineTitleLabel.isHidden = true
    }
    
    private func configureVideo() {
        playerLayer = videoPlayerLayer()
        self.view.layer.insertSublayer(playerLayer, at: 1)
    }
    
    private func videoPlayerLayer() -> AVPlayerLayer {
        let path = Bundle.main.path(forResource: "onboarding", ofType:"mp4")
        let player = AVPlayer(url: URL(fileURLWithPath: path!))
        let resetPlayer = {
            player.seek(to: CMTime.zero)
            player.play()
        }
        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { notification in
            resetPlayer()
        }
        self.player = player
        return AVPlayerLayer(player: player)
    }
    
    private func configureGradientView() {
        let layer1 = CAGradientLayer()

        layer1.colors = [
            CGColor(red: 0.271, green: 0.071, blue: 0.71, alpha: 0),
            CGColor(red: 0.271, green: 0.071, blue: 0.71, alpha: 1)
        ]

        layer1.locations = [0.21, 0.76]
        layer1.startPoint = CGPoint(x: 0, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer1.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer1.position = view.center
        gradientView.layer.insertSublayer(layer1, at: 0)
    }
    
    private func configureButtons() {
        continueButtonView.roundCorners(radius: 12, corners: .allCorners)
        closeButton.roundCorners(radius: 8, corners: .allCorners)
        closeButton.isHidden = true
    }
    
    private func configureOutlineView() {
        outlineView.roundCorners(radius: 8, corners: .allCorners)
        outlineView.layer.borderWidth = 1
        outlineView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func configureDotViews(firstToHide: Int, secondToHide: Int) {
        
        for dotView in dotViews{
            dotView.isHidden = false
        }
        
        var currentDot = 0
        for dotView in dotViews {
            if currentDot == firstToHide || currentDot == secondToHide {
                dotView.isHidden = true
            }
            dotView.capsuleCorners()
            currentDot += 1
        }
    }
    
    private func configureNextPage() {
        // Page switcher
        switch page {
        // Second Page
        case 0:
            faceImage.isHidden = true
            outlineViewLabel.text = "Получить персональный курс"
            commentLabel.isHidden = false
            starStackView.isHidden = false
            configureDotViews(firstToHide: 0, secondToHide: 4)
            toggleButton.setImage(UIImage(named: "FC Toggle On"), for: .normal)
            isToggleOn = true
            break
        // Third Page
        case 1:
            closeButton.isHidden = false
            configureDotViews(firstToHide: 0, secondToHide: 2)
            toggleButton.setImage(UIImage(named: "FC Toggle On"), for: .normal)
            isToggleOn = true
            outlineTitleLabel.isHidden = false
            outlineTitleLabel.text = "3 дня бесплатно,"
            outlineViewLabel.text = "потом 5 290 ₽/год"
            break
        default:
            let planGenerationVC = PlanGenerationViewController.load(from: Screen.planGeneration)
            planGenerationVC.modalPresentationStyle = .fullScreen
            self.present(planGenerationVC, animated: false, completion: nil)
            break
        }
        page += 1
    }
    
    private func setupGestures() {
        continueButtonView.addTapGesture(target: self, action: #selector(continueTapped))
    }
    
    // MARK: - Gesture actions
    
    @objc func continueTapped() {
        configureNextPage()
    }
        
    // MARK: - @IBActions
    
    @IBAction func toggleButtonPressed(_ sender: Any) {
        toggleButton.setImage(isToggleOn ? UIImage(named: "FC Toggle Off"): UIImage(named: "FC Toggle On"), for: .normal)
        isToggleOn = !isToggleOn
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        let planGenerationVC = PlanGenerationViewController.load(from: Screen.planGeneration)
        planGenerationVC.modalPresentationStyle = .fullScreen
        self.present(planGenerationVC, animated: false, completion: nil)
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
