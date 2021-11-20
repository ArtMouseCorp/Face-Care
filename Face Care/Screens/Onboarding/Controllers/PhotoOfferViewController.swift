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
    
    @IBOutlet weak var firstProductView: UIView!
    @IBOutlet weak var firstProductBorderCircleView: UIView!
    @IBOutlet weak var firstProductInnerCircleView: UIView!
    
    @IBOutlet weak var secondProductView: UIView!
    @IBOutlet weak var secondProductBorderCircleView: UIView!
    @IBOutlet weak var secondProductInnerCircleView: UIView!
    
    // Labels
    @IBOutlet weak var continueButtonViewLabel: UILabel!
    
    @IBOutlet weak var outlineTitleLabel: UILabel!
    @IBOutlet weak var outlineViewLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var bottomFirstLabel: UILabel!
    @IBOutlet weak var bottomSecondLabel: UILabel!
    @IBOutlet weak var bottomThirdLabel: UILabel!
    
    @IBOutlet weak var firstProductTitleLabel: UILabel!
    @IBOutlet weak var firstProductLabel: UILabel!
    
    @IBOutlet weak var secondProductTitleLabel: UILabel!
    @IBOutlet weak var secondProductLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var faceImage: UIImageView!
    
    // Buttons
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // Stack Views
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var productsStackView: UIStackView!
    
    // ActivityIndicators
    @IBOutlet weak var firstProductActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var secondProductActivityIndicator: UIActivityIndicatorView!
    
    
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
    
    var firstProduct: StoreManager.Product?
    var secondProduct: StoreManager.Product?
    var selectedProduct: StoreManager.Product?
    
    var firstProductTitle: String = ""
    var firstProductSubtitle: String = ""
    var secondProductTitle: String = ""
    var secondProductSubtitle: String = ""
    
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
    
    private func setupFirstPage() {
        
        faceImage.show()
        commentLabel.hide()
        starStackView.hide()
        outlineTitleLabel.hide()
        productsStackView.hide()
        
        outlineViewLabel.localize(with: L.Onboarding.loadImage)
        
        configureDotViews(firstToHide: 2, secondToHide: 4)
        toggleButton.setImage(UIImage(named: "FC Toggle Off"), for: .normal)
        isToggleOn = false
        
        bottomFirstLabel.localize(with: L.Onboarding.Features.first)
        bottomSecondLabel.localize(with: L.Onboarding.Features.second)
        bottomThirdLabel.localize(with: L.Onboarding.Features.third)
        
        State.shared.setCurrentScreen(to: "Onboarding: Take Photo Screen")
        
    }
    
    private func setupSecondPage() {
        
        faceImage.hide()
        commentLabel.show()
        starStackView.show()
        outlineTitleLabel.hide()
        productsStackView.hide()
        
        outlineViewLabel.localize(with: L.Onboarding.personalPlan)
        
        configureDotViews(firstToHide: 0, secondToHide: 4)
        toggleButton.setImage(UIImage(named: "FC Toggle Off"), for: .normal)
        isToggleOn = false
        
        commentLabel.text = State.shared.getOffer().comment
        
        bottomFirstLabel.localize(with: L.Onboarding.Features.first)
        bottomSecondLabel.localize(with: L.Onboarding.Features.second)
        bottomThirdLabel.localize(with: L.Onboarding.Features.third)
        
        State.shared.setCurrentScreen(to: "Onboarding: Personal Plan Screen")
        
    }
    
    private func setupThirdPage() {
        
        State.shared.completeOnboarding()
        
        closeButton.hide(!State.shared.getOffer().view)
        faceImage.hide()
        outlineView.hide()
        productsStackView.show()
        
        firstProductView.roundCorners(radius: 8, corners: .allCorners)
        firstProductView.setBorder(width: 1, color: .white)
        
        firstProductBorderCircleView.capsuleCorners()
        firstProductBorderCircleView.setBorder(width: 2, color: .white)
        firstProductBorderCircleView.backgroundColor = .clear
        
        firstProductInnerCircleView.capsuleCorners()
        
        secondProductView.roundCorners(radius: 8, corners: .allCorners)
        secondProductView.setBorder(width: 1, color: .white)
        
        secondProductBorderCircleView.capsuleCorners()
        secondProductBorderCircleView.setBorder(width: 2, color: .white)
        secondProductBorderCircleView.backgroundColor = .clear
        
        secondProductInnerCircleView.capsuleCorners()
        secondProductInnerCircleView.backgroundColor = .clear
        
        configureDotViews(firstToHide: 0, secondToHide: 2)
        
        if self.paywallSource == .onboarding {
            updatePriceLabels()
        }
        
        commentLabel.text = State.shared.getOffer().comment
        continueButtonViewLabel.text = State.shared.getOffer().button
        
        bottomFirstLabel.localize(with: L.Settings.restore)
        bottomSecondLabel.localize(with: L.Subscription.termsOfUse)
        bottomThirdLabel.localize(with: L.Subscription.privacy)
        
        State.shared.setCurrentScreen(to: "Onboarding: Subscription Screen")
        
    }
    
    private func configurePage() {
        switch page {
        case 1: setupFirstPage()
        case 2: setupSecondPage()
        case 3: setupThirdPage()
        default: break
        }
    }
    
    private func setupGestures() {
        continueButtonView.addTapGesture(target: self, action: #selector(continueTapped))
        bottomFirstLabel.addTapGesture(target: self, action: #selector(restoreTapped))
        bottomSecondLabel.addTapGesture(target: self, action: #selector(termsTapped))
        bottomThirdLabel.addTapGesture(target: self, action: #selector(privacyTapped))
        firstProductView.addTapGesture(target: self, action: #selector(productViewTapped(_:)))
        secondProductView.addTapGesture(target: self, action: #selector(productViewTapped(_:)))
    }
    
    private func getProducts() {
        
        let productsIds = [
            State.shared.getOffer().trialPurchaseId,
            State.shared.getOffer().notTrialPurchaseId
        ]
        
        firstProductTitleLabel.hide()
        firstProductLabel.hide()
        secondProductTitleLabel.hide()
        secondProductLabel.hide()
        
        StoreManager.getProducts(for: productsIds) { products in
            
            guard products.count == 2 else { return }
            
            print(products)
            self.firstProduct = products[0]
            self.secondProduct = products[1]
            self.selectedProduct = self.firstProduct
        
            DispatchQueue.main.async {
                self.updatePriceLabels()
            }
            
        }
        
    }
    
    private func updatePriceLabels() {
        
        guard let firstProduct = firstProduct, let secondProduct = secondProduct else { return }
        
        if let trialPeriod = firstProduct.trialPeriod {
            
            self.firstProductTitle = State.shared.getOffer().trialTitle
                .components(separatedBy: "\n")[0]
                .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
            self.firstProductSubtitle = State.shared.getOffer().trialTitle
                .components(separatedBy: "\n")[1]
                .replacingOccurrences(of: "%subscription_price%", with: firstProduct.price)
                .replacingOccurrences(of: "%subscription_period%", with: firstProduct.subscriptionPeriod)
            
        } else {
            
            self.firstProductTitle = firstProduct.skProduct.getSubscriptionPeriod(showOne: true)
            self.firstProductSubtitle = firstProduct.price
            
        }
        
        if let trialPeriod = secondProduct.trialPeriod {
            
            self.secondProductTitle = State.shared.getOffer().trialTitle
                .components(separatedBy: "\n")[0]
                .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
            self.secondProductSubtitle = State.shared.getOffer().trialTitle
                .components(separatedBy: "\n")[1]
                .replacingOccurrences(of: "%subscription_price%", with: secondProduct.price)
                .replacingOccurrences(of: "%subscription_period%", with: secondProduct.subscriptionPeriod)
            
        } else {
            
            self.secondProductTitle = secondProduct.skProduct.getSubscriptionPeriod(showOne: true)
            self.secondProductSubtitle = secondProduct.price
            
        }
        
        if page == 3 {
            self.firstProductTitleLabel.text = self.firstProductTitle
            self.firstProductLabel.text = self.firstProductSubtitle
            
            self.secondProductTitleLabel.text = self.secondProductTitle
            self.secondProductLabel.text = self.secondProductSubtitle
            
            firstProductTitleLabel.show()
            firstProductLabel.show()
            secondProductTitleLabel.show()
            secondProductLabel.show()
            firstProductActivityIndicator.stopAnimating()
            secondProductActivityIndicator.stopAnimating()
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
    
    // MARK: - Gesture Actions
    
    @objc private func productViewTapped(_ tapGesture: UITapGestureRecognizer) {
        
        guard let view = tapGesture.view else { return }
        
        if view == firstProductView {
            selectedProduct = firstProduct
            firstProductInnerCircleView.backgroundColor = .white
            secondProductInnerCircleView.backgroundColor = .clear
            return
        }
        
        if view == secondProductView {
            selectedProduct = secondProduct
            firstProductInnerCircleView.backgroundColor = .clear
            secondProductInnerCircleView.backgroundColor = .white
            return
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func toggleButtonPressed(_ sender: Any) {
        toggleButton.setImage(isToggleOn ? UIImage(named: "FC Toggle Off"): UIImage(named: "FC Toggle On"), for: .normal)
        isToggleOn = !isToggleOn
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
