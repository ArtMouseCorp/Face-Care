import UIKit
import AVFoundation
import ApphudSDK

class PhotoOfferViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet var dotViews: [UIView]!
    @IBOutlet weak var continueButtonView: UIView!
    @IBOutlet weak var outlineView: UIView!
    
    // Labels
    @IBOutlet weak var continueButtonViewLabel: UILabel!
    @IBOutlet weak var outlineTitleLabel: UILabel!
    @IBOutlet weak var outlineViewLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var bottomFirstLabel: UILabel!
    @IBOutlet weak var bottomSecondLabel: UILabel!
    @IBOutlet weak var bottomThirdLabel: UILabel!
    
    
    // Image Views
    @IBOutlet weak var faceImage: UIImageView!
    
    // Buttons
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // Stack Views
    @IBOutlet weak var starStackView: UIStackView!
    
    // MARK: - Variables
    
    internal enum PaywallSource {
        case onboarding, home
    }
    
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
    
    var paywallSource: PaywallSource = .onboarding
    
    var isSubviewed = false
    var isToggleOn: Bool = false
    var page = 1
    
    var trialProduct: StoreManager.Product?
    var notTrialProduct: StoreManager.Product?
    var selectedProduct: StoreManager.Product?
    
    var subscriptionTitle: String = ""
    var subscriptionSubtitle: String = ""
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Offer.get()
        configureVideo()
        playerLayer.frame = self.view.layer.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resize
        setupGestures()
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        configureGradientView()
        configureButtons()
        configureOutlineView()
        configurePage()
    }
    
    private func localize() {
        continueButtonViewLabel.localize(with: L.Onboarding.OnboardingButton.continue)
    }
    
    private func configureVideo() {
        playerLayer = videoPlayerLayer()
        self.view.layer.insertSublayer(playerLayer, at: 1)
    }
    
    private func videoPlayerLayer() -> AVPlayerLayer {
        let path = Bundle.main.path(forResource: "onboarding", ofType: "mp4")
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
    
    private func configurePage() {
        // Page switcher
        switch page {
            // First Page
        case 1:
            
            commentLabel.isHidden = true
            starStackView.isHidden = true
            outlineTitleLabel.isHidden = true
            
            outlineViewLabel.localize(with: L.Onboarding.loadImage)
            
            configureDotViews(firstToHide: 2, secondToHide: 4)
            toggleButton.setImage(UIImage(named: "FC Toggle Off"), for: .normal)
            isToggleOn = false
            
            bottomFirstLabel.localize(with: L.Onboarding.Features.first)
            bottomSecondLabel.localize(with: L.Onboarding.Features.second)
            bottomThirdLabel.localize(with: L.Onboarding.Features.third)
            
            State.shared.setCurrentScreen(to: "Onboarding: Take Photo Screen")
            
            break
            // Second Page
        case 2:
            
            faceImage.isHidden = true
            outlineViewLabel.localize(with: L.Onboarding.personalPlan)
            commentLabel.isHidden = false
            starStackView.isHidden = false
            outlineTitleLabel.isHidden = true
            configureDotViews(firstToHide: 0, secondToHide: 4)
            toggleButton.setImage(UIImage(named: "FC Toggle Off"), for: .normal)
            isToggleOn = false
            commentLabel.text = State.shared.getOffer().comment
            
            bottomFirstLabel.localize(with: L.Onboarding.Features.first)
            bottomSecondLabel.localize(with: L.Onboarding.Features.second)
            bottomThirdLabel.localize(with: L.Onboarding.Features.third)
            
            State.shared.setCurrentScreen(to: "Onboarding: Personal Plan Screen")
            
            break
            // Third Page
        case 3:

            State.shared.completeOnboarding()
            closeButton.isHidden = false
            faceImage.isHidden = true
            configureDotViews(firstToHide: 0, secondToHide: 2)
            self.isToggleOn = true
            self.toggleButton.setImage(UIImage(named: "FC Toggle On"), for: .normal)
            
            updatePriceLabels()
            
            outlineTitleLabel.isHidden = false
            
            self.outlineTitleLabel.text = self.subscriptionTitle
            self.outlineViewLabel.text = self.subscriptionSubtitle
            
            commentLabel.text = State.shared.getOffer().comment
            continueButtonViewLabel.text = State.shared.getOffer().button
            
            bottomFirstLabel.localize(with: L.Settings.restore)
            bottomSecondLabel.localize(with: L.Subscription.termsOfUse)
            bottomThirdLabel.localize(with: L.Subscription.privacy)
            
            State.shared.setCurrentScreen(to: "Onboarding: Subscription Screen")
            break
        default:
            break
        }
    }
    
    private func setupGestures() {
        continueButtonView.addTapGesture(target: self, action: #selector(continueTapped))
        bottomFirstLabel.addTapGesture(target: self, action: #selector(restoreTapped))
        bottomSecondLabel.addTapGesture(target: self, action: #selector(termsTapped))
        bottomThirdLabel.addTapGesture(target: self, action: #selector(privacyTapped))
    }
    
    private func getProducts() {
        
        let productsIds = [
            State.shared.getOffer().trialPurchaseId,
            State.shared.getOffer().notTrialPurchaseId
        ]
        
        StoreManager.getProducts(for: productsIds) { products in
            
            guard products.count == 2 else { return }
            
            self.trialProduct = products[0]
            self.notTrialProduct = products[1]
        
            self.updatePriceLabels()
            
        }
        
    }
    
    private func updatePriceLabels() {
        
        if isToggleOn {
            
            guard let product = trialProduct, let trialPeriod = product.trialPeriod else { return }

            self.subscriptionTitle = State.shared.getOffer().trialTitle
                .components(separatedBy: "\n")[0]
                .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
            self.subscriptionSubtitle = State.shared.getOffer().trialTitle
                .components(separatedBy: "\n")[1]
                .replacingOccurrences(of: "%subscription_price%", with: product.price)
                .replacingOccurrences(of: "%subscription_period%", with: product.subscriptionPeriod)
            self.selectedProduct = product
            
        } else {
            
            guard let product = notTrialProduct else { return }
            
            self.subscriptionTitle = product.skProduct.getSubscriptionPeriod(showOne: true)
            self.subscriptionSubtitle = product.price
            
            self.selectedProduct = product
        }
        
        if page == 3 {
            self.outlineTitleLabel.text = self.subscriptionTitle
            self.outlineViewLabel.text = self.subscriptionSubtitle
        }
        
    }
    
    // MARK: - Gesture actions
    
    @objc func continueTapped() {
        if page == 1 && isToggleOn {
            takePhoto()
            return
        }
        
        if page == 3 {
            // TODO: - Uncomment
            guard let selectedProduct = selectedProduct else { return }
            
            StoreManager.purchase(selectedProduct) {
                
                if self.paywallSource == .onboarding {
                    
                    let planGenerationVC = PlanGenerationViewController.load(from: Screen.planGeneration)
                    planGenerationVC.modalPresentationStyle = .fullScreen
                    self.present(planGenerationVC, animated: false, completion: nil)
                }
                
                if self.paywallSource == .home {
                    self.dismiss(animated: true)
                }

            }
            
            return
            
        }
        
        page += 1
        configurePage()
    }
    
    @objc private func privacyTapped() {
        guard page == 3 else { return }
        guard let url = URL(string: Config.privacyURL) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func termsTapped() {
        guard page == 3 else { return }
        guard let url = URL(string: Config.termsURL) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func restoreTapped() {
        guard page == 3 else { return }
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        StoreManager.updateStatus()
        
        guard !State.shared.isSubscribed else {
            self.showAlreadySubscribedAlert()
            return
        }
        
        StoreManager.restore() {
            
            if self.paywallSource == .onboarding {
                
                let planGenerationVC = PlanGenerationViewController.load(from: Screen.planGeneration)
                planGenerationVC.modalPresentationStyle = .fullScreen
                self.present(planGenerationVC, animated: false, completion: nil)
            }
            
            if self.paywallSource == .home {
                self.dismiss(animated: true)
            }
            
        }
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func toggleButtonPressed(_ sender: Any) {
        toggleButton.setImage(isToggleOn ? UIImage(named: "FC Toggle Off"): UIImage(named: "FC Toggle On"), for: .normal)
        isToggleOn = !isToggleOn
        
        if page == 3 {
            updatePriceLabels()
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        if paywallSource == .onboarding {
            
            let planGenerationVC = PlanGenerationViewController.load(from: Screen.planGeneration)
            planGenerationVC.modalPresentationStyle = .fullScreen
            self.present(planGenerationVC, animated: false, completion: nil)
            return
        }
        
        if paywallSource == .home {
            
            self.dismiss(animated: true)
            
        }
        
    }
    
}

extension PhotoOfferViewController {
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            self.page = 2
            self.configurePage()
            return
        }
        
        let newImage = ProgressImage(context: context)
        newImage.image = image
        
        do {
            try context.save()
        } catch {}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.page = 2
            self.configurePage()
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
