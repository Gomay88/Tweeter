
import Foundation

protocol LoginInteractor {
    func execute(completion: @escaping (_ logged: Bool) -> ())
}

class LoginInteractorDefault: LoginInteractor {
    private var tweeterRepository: TweeterRepository
    
    init() {
        tweeterRepository = TweeterRepositoryDefault()
    }
    
    func execute(completion: @escaping (Bool) -> ()) {
        tweeterRepository.oauthLogin(completion: completion)
    }
}
