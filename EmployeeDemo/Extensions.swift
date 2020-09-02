

import UIKit

extension UIView {
    func addAutolayoutSubview(_ view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func apply<T:UIView>(_ view: T, completion:((T))->Void){
        completion(view)
    }
}

extension NSObject {
    func showActivityIndicator(view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .darkText
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.bringSubviewToFront(activityIndicator)
        view.addSubview(activityIndicator)
        return activityIndicator
    }
    
    func removeActivityindicator(indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.stopAnimating()
        }
    }
}

extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
