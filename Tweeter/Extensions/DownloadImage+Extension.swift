
import UIKit

extension UIImageView{
    func load(url: URL?) {
        guard let url = url else {
            return
        }
        
        startSpinner()
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.endSpinner()
                    }
                }
            } catch {
                self?.endSpinner()
            }
        }
    }
}
