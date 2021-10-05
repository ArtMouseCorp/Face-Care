import UIKit
import Amplitude

class OnboardingViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var currentProgressView: UIView!
    
    // Labels
    @IBOutlet weak var mainLabel: UILabel!

    // Buttons
    @IBOutlet weak var yesButton: FCButton!
    @IBOutlet weak var noButton: FCButton!
    @IBOutlet weak var continueButton: FCButton!
    
    @IBOutlet weak var firstButton: FCButton!
    @IBOutlet weak var secondButton: FCButton!
    @IBOutlet weak var thirdButton: FCButton!
    @IBOutlet weak var fourthButton: FCButton!
    @IBOutlet weak var fifthButton: FCButton!
    
    // Stack view
    @IBOutlet weak var stackView: UIStackView!
    
    // Text fields
    @IBOutlet weak var textField: UITextField!
    
    // Image Views
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var firstButtonCheckmarkImage: UIImageView!
    @IBOutlet weak var secondButtonCheckmarkImage: UIImageView!
    @IBOutlet weak var thirdButtonCheckmarkImage: UIImageView!
    @IBOutlet weak var fourthButtonCheckmarkImage: UIImageView!
    @IBOutlet weak var fifthButtonCheckmarkImage: UIImageView!
    
    // Constraints
    @IBOutlet weak var currentProgressViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var currentProgress = 0
    var screenWidth = UIScreen.main.bounds.width
    
    var firstButtonClicked = false
    var secondButtonCliked = false
    var thirdButtonClicked = false
    var fourthButtonClicked = false
    var fifthButtonClicked = false
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        continueButton.configure(as: .filled)
        yesButton.configure(as: .filled)
        noButton.configure(as: .outlined)
        
        progressView.roundCorners(radius: 2, corners: .allCorners)
        currentProgressView.roundCorners(radius: 2, corners: .allCorners)
        
        textField.layer.cornerRadius = 12
        textField.isHidden = true
        textField.setBorder(width: 1, color: UIColor.FCDarkCharcoal)
        
        stackView.isHidden = true
        configureButtons()
        resetViews()
        
        currentProgressViewWidthConstraint.constant = ((screenWidth-32) * CGFloat(currentProgress)) / 9
    }
    
    private func localize() {
        yesButton.localize(with: L.Onboarding.OnboardingButton.yes)
        noButton.localize(with: L.Onboarding.OnboardingButton.no)
        continueButton.localize(with: L.Onboarding.OnboardingButton.continue)
    }
    
    private func configureButtons() {
        continueButton.isHidden = true
        for button in stackView.subviews {
            let view = button as! FCButton
            view.configure(as: .outlined)
        }
    }
    
    private func resetViews() {
        currentProgress += 1
        switch currentProgress {
        case 1:
            setupFirstView()
        case 2:
            setupSecondView()
        case 3:
            setupThirdView()
        case 4:
            setupFourthView()
        case 5:
            setupFifthView()
        case 6:
            setupSixView()
        case 7:
            setupSevenView()
        case 8:
            setupEightView()
        case 9:
            setupNineView()
        case 10:
            Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.ninthtPassed)
            let pickImageOffer = PhotoOfferViewController.load(from: Screen.photoOffer)
            pickImageOffer.modalPresentationStyle = .fullScreen
            self.present(pickImageOffer, animated: true, completion: nil)
            return
        default:
            return
        }
        currentProgressViewWidthConstraint.constant = ((screenWidth-32) * CGFloat(currentProgress)) / 9
        
    }
    
    private func setupFirstView() {
        mainLabel.localize(with: L.Onboarding.Screen.Title.first)
        State.shared.setCurrentScreen(to: "Onboarding: First Screen")
    }
    
    private func setupSecondView() {
        mainImageView.image = UIImage(named: "plan-generation-image-3")
        mainLabel.localize(with: L.Onboarding.Screen.Title.second)
        State.shared.setCurrentScreen(to: "Onboarding: Second Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.firstPassed)
    }
    
    func setupThirdView() {
        yesButton.isHidden = true
        noButton.isHidden = true
        mainImageView.isHidden = true
        stackView.isHidden = false
        mainLabel.localize(with: L.Onboarding.Screen.Title.third)
        
        firstButton.localize(with: L.Onboarding.SkinType.normal)
        secondButton.localize(with: L.Onboarding.SkinType.combined)
        thirdButton.localize(with: L.Onboarding.SkinType.fat)
        fourthButton.localize(with: L.Onboarding.SkinType.dry)
        fifthButton.isHidden = true
        
        self.view.layoutIfNeeded()
        State.shared.setCurrentScreen(to: "Onboarding: Third Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.secondPassed)
    }
    
    func setupFourthView() {
        continueButton.isHidden = false
        mainLabel.localize(with: L.Onboarding.Screen.Title.fourth)
        
        
        firstButton.localize(with: L.FacePart.eyes)
        secondButton.localize(with: L.FacePart.forehead)
        thirdButton.localize(with: L.FacePart.neck)
        fourthButton.localize(with: L.FacePart.chin)
        fifthButton.localize(with: L.FacePart.cheekbonesAndCheeks)
        
        fifthButton.isHidden = false
        
        updateProblemAreaButton()
        
        State.shared.setCurrentScreen(to: "Onboarding: Fourth Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.thirdPassed)
    }
    
    func setupFifthView() {
        continueButton.isHidden = true
        mainLabel.localize(with: L.Onboarding.Screen.Title.fifth)
        
        firstButton.localize(with: L.Onboarding.OnboardingButton.yes)
        secondButton.localize(with: L.Onboarding.OnboardingButton.eyesWrinkles)
        thirdButton.localize(with: L.Onboarding.OnboardingButton.yes)
        fourthButton.isHidden = true
        fifthButton.isHidden = true
        
        // Deselect
        deselectButton(button: firstButton)
        deselectButton(button: secondButton)
        deselectButton(button: thirdButton)
        
        State.shared.setCurrentScreen(to: "Onboarding: Fifth Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.fourthPassed)
    }
    
    func setupSixView() {
        mainLabel.localize(with: L.Onboarding.Screen.Title.sixth)
        
        State.shared.setCurrentScreen(to: "Onboarding: Sixth Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.fifthPassed)
    }
    
    func setupSevenView() {
        mainLabel.localize(with: L.Onboarding.Screen.Title.seventh)
        
        firstButton.localize(with: L.Onboarding.OnboardingButton.Sleep.short)
        secondButton.localize(with: L.Onboarding.OnboardingButton.Sleep.normal)
        thirdButton.localize(with: L.Onboarding.OnboardingButton.Sleep.long)
        
        State.shared.setCurrentScreen(to: "Onboarding: Seventh Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.sixthPassed)
    }
    
    func setupEightView() {
        stackView.isHidden = true
        mainLabel.localize(with: L.Onboarding.Screen.Title.eighth)
        continueButton.isHidden = false
        textField.isHidden = false
        textField.text = ""
        textField.autocapitalizationType = .words
        textField.textContentType = .name
        textField.keyboardType = .default
        continueButton.disable()
        
        State.shared.setCurrentScreen(to: "Onboarding: Eighth Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.seventhPassed)
    }
    
    func setupNineView() {
        mainLabel.localize(with: L.Onboarding.Screen.Title.ninth)
        textField.text = ""
        textField.autocapitalizationType = .none
        textField.textContentType = .none
        textField.keyboardType = .numberPad
        continueButton.disable()
        
        State.shared.setCurrentScreen(to: "Onboarding: Ninth Screen")
        Amplitude.instance().logEvent(AmplitudeEvent.Onboarding.eighthPassed)
    }
    
    func deselectButton(button: UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.FCDarkCharcoal.cgColor
        button.setTitleColor(UIColor.FCDarkCharcoal, for: .normal)
    }
    
    func selectButton(button: UIButton) {
        button.backgroundColor = UIColor.FCIris
        button.layer.borderColor = UIColor.FCIris.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func updateProblemAreaButton() {
        
        guard currentProgress == 4 else { return }
        self.continueButton.disable(State.shared.getProblemAreas().isEmpty)
        
    }
    
    
    // MARK: - @IBActions
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        resetViews()
    }
    
    @IBAction func noButtonClicked(_ sender: Any) {
        resetViews()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        if currentProgress == 8 {
            let userName = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "User"
            State.shared.saveUserName(userName)
        }
        
        if currentProgress == 9 {
            let userAge = Int(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0") ?? 0
            State.shared.saveUserAge(userAge)
        }
        
        resetViews()
    }
    
    // First button
    @IBAction func firstButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        }
        else {
            if firstButtonClicked {
                deselectButton(button: firstButton)
                State.shared.removeProblemArea(1)
            }
            else {
                selectButton(button: firstButton)
                State.shared.addProblemArea(1)
            }
            firstButtonClicked = !firstButtonClicked
            updateProblemAreaButton()
        }
    }
    
    // Second button
    @IBAction func secondButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        }
        else {
            if secondButtonCliked {
                deselectButton(button: secondButton)
                State.shared.removeProblemArea(2)
            }
            else {
                selectButton(button: secondButton)
                State.shared.addProblemArea(2)
            }
            secondButtonCliked = !secondButtonCliked
            updateProblemAreaButton()
        }
    }
    
    // Third button
    @IBAction func thirdButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        }
        else {
            if thirdButtonClicked {
                deselectButton(button: thirdButton)
                State.shared.removeProblemArea(3)
            }
            else {
                selectButton(button: thirdButton)
                State.shared.addProblemArea(3)
            }
            thirdButtonClicked = !thirdButtonClicked
            updateProblemAreaButton()
        }
    }
    
    // Fourth button
    @IBAction func fourthButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        } else {
            if fourthButtonClicked {
                deselectButton(button: fourthButton)
                State.shared.removeProblemArea(4)
            }
            else {
                selectButton(button: fourthButton)
                State.shared.addProblemArea(4)
            }
            fourthButtonClicked = !fourthButtonClicked
            updateProblemAreaButton()
        }
    }
    
    // Fifth button
    @IBAction func fifthButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        } else {
            if fifthButtonClicked {
                deselectButton(button: fifthButton)
                State.shared.removeProblemArea(5)
            }
            else {
                selectButton(button: fifthButton)
                State.shared.addProblemArea(5)
            }
            fifthButtonClicked = !fifthButtonClicked
            updateProblemAreaButton()
        }
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        
        guard currentProgress == 8 || currentProgress == 9 else { return }
        continueButton.disable((textField.text ?? "").isEmpty)
        
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
