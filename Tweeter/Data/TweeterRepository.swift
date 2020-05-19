
import Foundation

protocol TweeterRepository {
    func oauthLogin(completion: @escaping (_ logged: Bool) -> ())
}

class TweeterRepositoryDefault: BaseRepository, TweeterRepository {
    func oauthLogin(completion: @escaping (Bool) -> ()) {
        let token = Constants.apiKey + ":" + Constants.apiSecret
        
        let request = RequestBuilder.tweeter()
            .post()
            .headers(["Authorization": "Basic \(Data(token.utf8).base64EncodedString())","Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"])
            .parameter("grant_type=client_credentials")
            .path("oauth2/token")
            .builtHttpRequest()
        
        execute(request: request, responseType: OauthResponse.self) { (oauth, error) in
            guard let token = oauth?.access_token else {
                completion(false)
                return
            }
            
            Constants.token = "Bearer \(token)"
            completion(true)
        }
    }
}
