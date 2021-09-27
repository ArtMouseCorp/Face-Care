import UIKit

class ArticlesViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Table Views
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Article.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.article.id, for: indexPath) as! ArticleTableViewCell
         
        let article = Article.all[indexPath.row]
        
        if indexPath.row == 0 {
            cell.cellTopConstraint.constant = 26
        }
        
        cell.initialize(title: article.title, image: UIImage(named: article.image))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = Article.all[indexPath.row]
        let articleVC = ArticleViewController.load(from: Screen.article)
        articleVC.article = article
        self.navigationController?.pushViewController(articleVC, animated: true)
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
