
import Foundation

protocol TwitDetailPresenter {
    func setView(view: TwitDetailViewController)
    func getTwitAvatar() -> URL?
    func getTwitAuthor() -> String
    func getTwitLongitude() -> Double?
    func getTwitLatitude() -> Double?
    func getTwitFollowers() -> Int
    func getTwitTweets() -> Int
    func getTwitFavourites() -> Int
    func getTwitRetweets() -> Int
    func getTwitReplies() -> Int
}

class TwitDetailPresenterDefault: TwitDetailPresenter {
    
    private weak var view: TwitDetailViewController?
    private var twit: Twit
    
    init(twit: Twit) {
        self.twit = twit
    }
    
    func setView(view: TwitDetailViewController) {
        self.view = view
    }
    
    func getTwitAvatar() -> URL? {
        return twit.avatarURLPath
    }
    
    func getTwitAuthor() -> String {
        return twit.name
    }
    
    func getTwitLongitude() -> Double? {
        return twit.longitude
    }
    
    func getTwitLatitude() -> Double? {
        return twit.latitude
    }
    
    func getTwitFollowers() -> Int {
        return twit.followers
    }
    
    func getTwitTweets() -> Int {
        return twit.tweets
    }
    
    func getTwitFavourites() -> Int {
        return twit.favourites
    }
    
    func getTwitRetweets() -> Int {
        return twit.retweet
    }
    
    func getTwitReplies() -> Int {
        return twit.reply
    }
}
