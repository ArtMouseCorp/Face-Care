import UIKit
import MessageUI
import Amplitude

class SettingsViewController: BaseViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var languageButtonView: UIView!
    @IBOutlet weak var contactButtonView: UIView!
    @IBOutlet weak var renewSubscriptionButtonView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contactusLabel: UILabel!
    @IBOutlet weak var refreshSubscriptionLabel: UILabel!
    
    // Buttons
    
    // Image Views
    @IBOutlet weak var languageChevronImageView: UIImageView!
    
    // Stack Views
    @IBOutlet weak var settingsStackView: UIStackView!
    
    // Table Views
    @IBOutlet weak var languageTableView: UITableView!
    
    // Constraints
    @IBOutlet weak var languageTableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    private var languagesIsShown: Bool = false
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(languageTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        configureUI()
        setupGestures()
        State.shared.setCurrentScreen(to: "Settings Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        languageChevronImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        languageTableViewHeightConstraint.constant = 0
        languageTableView.isHidden = true
        languageTableView.alpha = 0
    }
    
    private func localize() {
        
        print("Localize, ", State.shared.getLanguage() )
    
        titleLabel.localize(with: L.Settings.title)
        languageLabel.localize(with: L.Settings.Language.title)
        contactusLabel.localize(with: L.Settings.contact)
        refreshSubscriptionLabel.localize(with: L.Settings.restore)
    }
    
    private func setupGestures() {
        languageButtonView.addTapGesture(target: self, action: #selector(languageButtonViewTapped))
        contactButtonView.addTapGesture(target: self, action: #selector(contactButtonViewTapped))
        renewSubscriptionButtonView.addTapGesture(target: self, action: #selector(renewSubscriptionButtonViewTapped))
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    // MARK: - Gesture actions
    
    @objc private func languageButtonViewTapped() {
        
        languageChevronImageView.transform = languagesIsShown ? CGAffineTransform(rotationAngle: CGFloat.pi / 2) : CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        UIView.animate(withDuration: 0.2) {
            
            self.languageTableView.isHidden = self.languagesIsShown
            self.languageTableViewHeightConstraint.constant = self.languagesIsShown ? 0 : self.languageTableView.contentHeight
            self.languageTableView.alpha = self.languagesIsShown ? 0 : 1
            self.settingsStackView.layoutIfNeeded()
        } completion: { _ in
            self.languagesIsShown = !self.languagesIsShown
        }
        
    }
    
    @objc private func contactButtonViewTapped() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["artmousedev@gmail.com"])
            mail.setSubject("Face Care Contact")
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true)
        }
    }
    
    @objc private func renewSubscriptionButtonViewTapped() {
        // TODO:  - Restore user's subscription
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.language.id, for: indexPath) as! LanguageTableViewCell
        
        let index = Language.languages.firstIndex { $0.code == State.shared.getLanguage() }
        
        cell.configure(with: Language.languages[indexPath.row], selected: indexPath.row == index)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        State.shared.setLanguage(to: Language.languages[indexPath.row].code)
        DispatchQueue.main.async {
            self.localize()
            self.languageTableView.reloadData()
        }
        
        Amplitude.instance().logEvent(AmplitudeEvent.languageChanged, withEventProperties: [
            "Language Changed To": Language.languages[indexPath.row].code
        ])
        
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
