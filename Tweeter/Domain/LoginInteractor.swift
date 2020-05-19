
import Foundation

protocol LoginInteractor {
    func execute(completion: @escaping (_ token: String?, _ error: Error?) -> ())
}

class LoginInteractorDefault: LoginInteractor {
    
    private var tweeterRepository: TweeterRepository
    
    init() {
        tweeterRepository = TweeterRepositoryDefault()
    }
    
    func execute(completion: @escaping (_ token: String?, _ error: Error?) -> ()) {
        tweeterRepository.oauthLogin { (oauth, error) in
            completion(oauth?.access_token, error)
        }
    }
}
