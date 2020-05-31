
import UIKit
import SafariServices

class ListTweetsViewController: UIViewController, Alertable, Spinnable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter: ListTweetsPresenter = ListTweetsPresenterDefault()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.setView(view: self)
        presenter.logInTweeter()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func presentSafari(url: String) {
        guard let url = URL(string: url) else {
            return
        }

        DispatchQueue.main.async {
            self.present(SFSafariViewController(url: url), animated: true, completion: nil)
        }
    }
    
    func dismissSafari(completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }
    
    func loadData() {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    func navigateToTwitDetail(twit: Twit) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let twitDetailViewController = storyBoard.instantiateViewController(withIdentifier: "TwitDetailViewController") as? TwitDetailViewController else {
            return
        }
        twitDetailViewController.presenter = TwitDetailPresenterDefault(twit: twit)
        present(twitDetailViewController, animated: true)
    }
}

extension ListTweetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTwits()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTweetsCell", for: indexPath) as! ListTweetsCell
        cell.avatarImageView.load(url: presenter.twitImagePathForRow(row: indexPath.row))
        cell.nameLabel.text = presenter.twitAuthorForRow(row: indexPath.row)
        
        let twitText = presenter.twitTextForRow(row: indexPath.row)
        cell.twitLabel.attributedText = boldText(string: twitText, boldStrings: ["ME", "I"], font: cell.twitLabel.font)
        
        return cell
    }
    
    private func boldText(string: String, boldStrings: [String], font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        
        for boldString in boldStrings {
            let range = (string as NSString).localizedStandardRange(of: boldString)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        
        return attributedString
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectTwit(row: indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
