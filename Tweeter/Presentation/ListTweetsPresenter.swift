
import Foundation
import SwifteriOS
import SafariServices

protocol ListTweetsPresenter {
    func setView(view: ListTweetsViewController)
    func logInTweeter()
}

class ListTweetsPresenterDefault: NSObject, ListTweetsPresenter, SFSafariViewControllerDelegate {
    
    private let requestTokenInteractor: RequestTokenInteractor = RequestTokenInteractorDefault()
    private let accessTokenInteractor: AccessTokenInteractor = AccessTokenInteractorDefault()
    private let twitsInteractor: GetTweetsInteractor = GetTweetsInteractorDefault()
    
    private weak var view: ListTweetsViewController?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(didLogInTwitter), name: NSNotification.Name("LoggedInTwitter"), object: nil)
    }
    
    func setView(view: ListTweetsViewController) {
        self.view = view
    }
    
    func logInTweeter() {
        requestTokenInteractor.execute { (url, error) in
            guard let url = url else {
                return
            }
            
            self.view?.presentSafari(url: url)
        }
    }
    
    @objc func didLogInTwitter() {
        view?.dismissSafari(completion: {
            self.accessTokenInteractor.execute { (hasLoggedIn) in
                if hasLoggedIn {
                    self.twitsInteractor.execute { (twits, error) in
                        print(twits)
                        print(error)
                    }
                }
            }
        })
    }
}
