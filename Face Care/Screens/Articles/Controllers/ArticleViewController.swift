import UIKit

class ArticleViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var imageBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    
    // Image Views
    @IBOutlet weak var articleImageView: UIImageView!
    
    // Constraint
    @IBOutlet weak var imageBackgroundViewHeightConstraing: NSLayoutConstraint!
    @IBOutlet weak var articleTextLabelHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var article: Article = .default
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        State.shared.setCurrentScreen(to: "Article Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        imageBackgroundView.roundCorners(radius: 16, corners: .allCorners)
        imageBackgroundView.clipsToBounds = true
        
        articleTitleLabel.text = article.title
        articleImageView.image = UIImage(named: article.image)
        
        imageBackgroundViewHeightConstraing.constant = min((UIScreen.main.bounds.width - 32) / 1.2035087719, 600)
        
        DispatchQueue.main.async {
            
            let gradient = CAGradientLayer()
            
            gradient.frame = self.articleImageView.frame
            
            gradient.colors = [
                UIColor.FCBlack.withAlphaComponent(0).cgColor,
                UIColor.FCBlack.withAlphaComponent(0.5).cgColor
            ]
            gradient.locations = [0.5, 1]
            
            self.articleImageView.layer.addSublayer(gradient)
            
            // Labels
            self.styledArticleText()
            self.articleTextLabelHeightConstraint.constant = self.articleTextLabel.contentHeight(lineSpacing: 4)
            
        }
        
    }
    
    private func localize() {
        titleLabel.localize(with: L.Atricles.title)
    }
    
    private func styledArticleText() {
        
        var text = article.text
        var titles: [String] = []
        
        while let title = text.slice(from: "<t>", to: "</t>") {
            
            titles.append(title)
            let openRange = text.range(of: "<t>")!
            text = text
                .replacingOccurrences(of: "<t>", with: "\n\n", range: openRange)
            
        }
        
        text = text
            .replacingOccurrences(of: "<t>", with: "\n\n")
            .replacingOccurrences(of: "</t>", with: "\n\n")
        
        let attributedString = NSMutableAttributedString(string: text)
        
        titles.forEach { title in
            let range = NSRange(text.range(of: title)!, in: text)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.ralewayFont(ofSize: 16, weight: .bold)
            ]
            
            attributedString.setAttributes(attributes, range: range)
            
        }
        
        self.articleTextLabel.attributedText = attributedString
        
    }
    
    
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
