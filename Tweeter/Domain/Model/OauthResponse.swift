
import Foundation

struct OauthResponse: Decodable {
    let token_type: String
    let access_token: String
}
