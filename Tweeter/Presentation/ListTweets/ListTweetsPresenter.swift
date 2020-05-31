
import Foundation

protocol ListTweetsPresenter {
    func setView(view: ListTweetsViewController)
    func logInTweeter()
    func numberOfTwits() -> Int
    func twitAuthorForRow(row: Int) -> String
    func twitTextForRow(row: Int) -> String
    func twitImagePathForRow(row: Int) -> URL?
    func didSelectTwit(row: Int)
}

class ListTweetsPresenterDefault: ListTweetsPresenter {
    
    private let requestTokenInteractor: RequestTokenInteractor = RequestTokenInteractorDefault()
    private let accessTokenInteractor: AccessTokenInteractor = AccessTokenInteractorDefault()
    private let twitsInteractor: GetTweetsInteractor = GetTweetsInteractorDefault()
    
    private var twits: [Twit] = []
    
    private weak var view: ListTweetsViewController?
    
    init() {
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
            self.view?.startSpinner()
            self.accessTokenInteractor.execute { (hasLoggedIn) in
                if hasLoggedIn {
                    self.twitsInteractor.execute { (twits) in
                        self.twits = twits
                        self.view?.endSpinner()
                        self.view?.loadData()
                    }
                } else {
                    self.view?.endSpinner()
                    self.view?.showError(error: RepositoryError.serverError)
                }
            }
        })
    }
    
    func numberOfTwits() -> Int {
        return twits.count
    }
    
    func twitAuthorForRow(row: Int) -> String {
        return twits[row].name
    }
    
    func twitTextForRow(row: Int) -> String {
        return twits[row].twitText
    }
    
    func twitImagePathForRow(row: Int) -> URL? {
        return twits[row].avatarURLPath
    }
    
    func didSelectTwit(row: Int) {
        view?.navigateToTwitDetail(twit: twits[row])
    }
}
