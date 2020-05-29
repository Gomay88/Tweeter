
import Foundation

protocol GetTweetsInteractor {
    func execute(completion: @escaping (_ tweets: String?, _ error: Error?) -> ())
}

class GetTweetsInteractorDefault: GetTweetsInteractor {
    private var twitterRepository: TwitterRepository
    
    init() {
        twitterRepository = TwitterRepositoryDefault()
    }
    
    func execute(completion: @escaping (_ tweets: String?, _ error: Error?) -> ()) {
        twitterRepository.getTwits(completion: completion)
    }
}
