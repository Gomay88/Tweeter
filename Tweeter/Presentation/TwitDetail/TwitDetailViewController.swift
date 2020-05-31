
import UIKit
import MapKit

class TwitDetailViewController: UIViewController, Spinnable, Alertable {
    
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var userTweetsLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var favouritesLabel: UILabel!
    
    var presenter: TwitDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(view: self)
        
        bottomStack.isHidden = true
        avatarImageView.load(url: presenter.getTwitAvatar())
        nameLabel.text = presenter.getTwitAuthor()
        followersLabel.text = "Total followers: \(presenter.getTwitFollowers())"
        userTweetsLabel.text = "Total tweets: \(presenter.getTwitTweets())"
        favouritesLabel.text = "Favourites: \(presenter.getTwitFavourites())"
        
        guard let longitude = presenter.getTwitLongitude() else {
            mapView.isHidden = true
            locationLabel.isHidden = true
            return
        }
        
        guard let latitude = presenter.getTwitLatitude() else {
            mapView.isHidden = true
            locationLabel.isHidden = true
            return
        }
        
        locationLabel.text = String(longitude) + ", " + String(latitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        annotation.title = presenter.getTwitAuthor()
        
        DispatchQueue.main.async {
            self.mapView.showAnnotations([annotation], animated: true)
        }
    }
    
    @IBAction func didTapShowMoreButton(_ sender: Any) {
        bottomStack.isHidden = !bottomStack.isHidden
    }
}
