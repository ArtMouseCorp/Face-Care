import UIKit

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
    
    // Constraints
    @IBOutlet weak var currentProgressViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var currentProgress = 1
    var screenWidth = UIScreen.main.bounds.width
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        currentProgressViewWidthConstraint.constant = ((screenWidth-32) * CGFloat(currentProgress)) / 9
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
        case 2:
            mainImageView.image = UIImage(named: "plan-generation-image-3")
            mainLabel.text = "Ты хочешь, чтобы лицо выглядело более подтянутым?"
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
            let pickImageOffer = PhotoOfferViewController.load(from: Screen.photoOffer)
            pickImageOffer.modalPresentationStyle = .fullScreen
            self.present(pickImageOffer, animated: true, completion: nil)
            return
        default:
            return
        }
        currentProgressViewWidthConstraint.constant = ((screenWidth-32) * CGFloat(currentProgress)) / 9
        
    }
    
    func setupThirdView() {
        yesButton.isHidden = true
        noButton.isHidden = true
        mainImageView.isHidden = true
        stackView.isHidden = false
        mainLabel.text = "Какой у тебя тип кожи?"
        firstButton.setTitle("Нормальная", for: .normal)
        secondButton.setTitle("Комбинированная", for: .normal)
        thirdButton.setTitle("Жирная", for: .normal)
        fourthButton.setTitle("Сухая", for: .normal)
        fifthButton.isHidden = true
        self.view.layoutIfNeeded()
    }
    
    func setupFourthView() {
        continueButton.isHidden = false
        mainLabel.text = "На какой области лица ты хотел(а) бы сосредоточится?"
        firstButton.setTitle("Глаза", for: .normal)
        secondButton.setTitle("Лоб", for: .normal)
        thirdButton.setTitle("Шея", for: .normal)
        fourthButton.setTitle("Подбородок", for: .normal)
        fifthButton.isHidden = false
        fifthButton.setTitle("Скулы и щеки", for: .normal)
    }
    
    func setupFifthView() {
        continueButton.isHidden = true
        mainLabel.text = "Заметны ли морщинки на лице когда ты улыбаешься или смеёшься?"
        firstButton.setTitle("Нет", for: .normal)
        secondButton.setTitle("Да, но только в области глаз", for: .normal)
        thirdButton.setTitle("Да", for: .normal)
        fourthButton.isHidden = true
        fifthButton.isHidden = true
    }
    
    func setupSixView() {
        mainLabel.text = "Заметны ли морщинки на твоём лице, когда оно расслаблено?"
    }
    
    func setupSevenView() {
        mainLabel.text = "Сколько часов обычно длится твой сон?"
        firstButton.setTitle("Меньше 7 часов", for: .normal)
        secondButton.setTitle("7-8 часов", for: .normal)
        thirdButton.setTitle("Больше 8 часов", for: .normal)
    }
    
    func setupEightView() {
        stackView.isHidden = true
        mainLabel.text = "Как тебя зовут?"
        continueButton.isHidden = false
        textField.isHidden = false
    }
    
    func setupNineView() {
        mainLabel.text = "Сколько тебе лет?"
    }
    
    // MARK: - @IBActions
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        resetViews()
    }
    
    @IBAction func noButtonClicked(_ sender: Any) {
        resetViews()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        resetViews()
    }
    
    @IBAction func firstButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        }
    }
    
    @IBAction func secondButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        }
    }
    
    @IBAction func thirdButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        }
    }
    
    @IBAction func fourthButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
        }
    }
    
    @IBAction func fifthButtonPressed(_ sender: Any) {
        if currentProgress != 4 {
            resetViews()
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
