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
    @IBOutlet weak var articleTextLabelHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var article: Article = .default
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        imageBackgroundView.roundCorners(radius: 16, corners: .allCorners)
        imageBackgroundView.clipsToBounds = true
        
        articleTitleLabel.text = article.title
        articleImageView.image = UIImage(named: article.image)
        articleTextLabel.text = article.text
        
        // Labels
        articleTextLabel.setLineHeight(lineHeight: 4)
        articleTextLabel.sizeToFit()
        articleTextLabelHeightConstraint.constant = articleTextLabel.frame.height
        
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
