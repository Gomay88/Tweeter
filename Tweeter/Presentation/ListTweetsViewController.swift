
import UIKit
import SafariServices

class ListTweetsViewController: UIViewController {
    
    private let presenter: ListTweetsPresenter = ListTweetsPresenterDefault()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.setView(view: self)
        presenter.logInTweeter()
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
}
