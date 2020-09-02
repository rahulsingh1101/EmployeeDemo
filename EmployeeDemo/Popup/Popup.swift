

import UIKit

class Popup: UIView {
    private var items: [Item]!
    private weak var delegate: PopupDelegate!
    private var anchor: UIView!
    private var button: UIView!
    
    var navigationBarHeight: CGFloat{
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            return navigationController.navigationBar.frame.height
        }
        return 0
    }
    
    var statusBarHeight: CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
    
    init(items:[Item], delegate:PopupDelegate, anchor on:UIView, onButtonTouch: UIView) {
        self.items = items
        self.delegate = delegate
        self.anchor = on
        self.button = onButtonTouch
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI(){
        self.backgroundColor = .clear
        addDropDown()
        let popup = PopupView(style: .plain, tappedView: self.button, items: items, delegate: self.delegate)
        popup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(popup)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
        let point = button.convert(button.bounds.origin, to: anchor)
        
        let popupTableViewHeight = CGFloat(items.count*50)
        let popupTableViewWidth = CGFloat(238)
    

        //  Decide to add leading or trailing
        if (point.x + popupTableViewWidth) < UIScreen.main.bounds.width {
            //  Activate leading
            popup.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: point.x).isActive = true
        } else {
            //  Activate trailing
            popup.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
        //  Decide to add top or bottom
        if (point.y + popupTableViewHeight + navigationBarHeight + statusBarHeight) < anchor.frame.height {
            popup.topAnchor.constraint(equalTo: self.topAnchor, constant: point.y+button.frame.height-navigationBarHeight-statusBarHeight).isActive = true
        } else {
            popup.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }
        
        NSLayoutConstraint.activate([

            popup.widthAnchor.constraint(equalToConstant: popupTableViewWidth),
            popup.heightAnchor.constraint(equalToConstant: popupTableViewHeight),
        ])
    }
    
    private func addDropDown(){
        self.translatesAutoresizingMaskIntoConstraints = false
        anchor.addSubview(self)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: anchor.safeAreaLayoutGuide.topAnchor, constant: 0),
                self.leadingAnchor.constraint(equalTo: anchor.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                self.trailingAnchor.constraint(equalTo: anchor.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                self.bottomAnchor.constraint(equalTo: anchor.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            ])
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
}

extension UIView{
    func setShadow(cornerRadius: CGFloat = 10, maskToBounds: Bool = false, shadowRadius: CGFloat = 10, shadowColor: UIColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1), shadowOpacity: Float = 0.4, shadowOffset: CGSize = CGSize(width: 0, height: 1)){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = maskToBounds
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.backgroundColor = .white
    }
}
