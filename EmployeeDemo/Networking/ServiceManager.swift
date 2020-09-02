

import Foundation
import Alamofire

class Connectivity{
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class ServiceManager: NSObject {
    static let shared = ServiceManager()
    
    func request<T:Decodable>(type:T.Type, url: String, method: HTTPMethod, controller:UIViewController, completion completionHandler:@escaping(T?) -> Void) {
        if Connectivity.isConnectedToInternet() {
            var activityIndicator = UIActivityIndicatorView()
            print("The url in service manager is :\(String(describing: url))")
            DispatchQueue.main.async {
                controller.view.isUserInteractionEnabled = false
                activityIndicator = self.showActivityIndicator(view: controller.view)
            }
            guard let url = URL(string: url) else { return }
            let headers = ["Content-Type": "application/json","Accept":"application/json"]
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForResource = TimeInterval(30)
            configuration.timeoutIntervalForRequest = TimeInterval(30)
            let sessionManager = Alamofire.SessionManager(configuration: configuration)
            sessionManager.request(url, method: method, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                switch (response.result) {
                    case .success:
                        guard let json = response.data else { return }
                        do{
                            let result = try JSONDecoder().decode(T.self, from: json)
                            DispatchQueue.main.async {
                                controller.view.isUserInteractionEnabled = true
                                self.removeActivityindicator(indicator: activityIndicator)
                            }
                            completionHandler(result)
                        }catch{
                            print(error)
                            DispatchQueue.main.async {
                                controller.view.isUserInteractionEnabled = true
                                self.removeActivityindicator(indicator: activityIndicator)
                                controller.popupAlert(title: "Error", message: Errors.decode.rawValue, actionTitles: ["OK"], actions: [
                                    nil
                                ])
                            }
                        }
                        break
                    case .failure( _):
                        DispatchQueue.main.async {
                            controller.popupAlert(title: "Error", message: Errors.serverError.rawValue, actionTitles: ["OK"], actions: [
                                nil
                            ])
                            controller.view.isUserInteractionEnabled = true
                            self.removeActivityindicator(indicator: activityIndicator)
                        }
                        break
                        }
                }.session.finishTasksAndInvalidate()
                
       } else {
            DispatchQueue.main.async {
                controller.popupAlert(title: "Error", message: Errors.noInternet.rawValue, actionTitles: ["OK"], actions: [
                    nil
                ])
            }
       }
    }
}
