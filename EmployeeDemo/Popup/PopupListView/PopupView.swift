

import UIKit

protocol PopupDelegate:class {
    func selectedPopupWith(item:Item, parentCellIndex: Int, index:Int)
}

struct Item {
    var name: String
    var image: String
}

class PopupView: UITableView,UITableViewDelegate, UITableViewDataSource {
    private var referenceView: UIView?
    private var items: [Item]!
    
    var headerTitles = [String]() {
        didSet {
            self.reloadSections(IndexSet.init(arrayLiteral: 0), with: .automatic)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    weak var popupDelegate: PopupDelegate!
    
    init(style: UITableView.Style, tappedView: UIView, items:[Item], delegate: PopupDelegate) {
        self.items = items
        self.popupDelegate = delegate
        self.referenceView = tappedView
        super.init(frame: .zero, style: .plain)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(){
        self.setShadow()
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = false
        self.register(UINib.init(nibName: "PopupCell", bundle: nil), forCellReuseIdentifier: "PopupCell")
        self.backgroundColor = .clear
        self.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopupCell", for: indexPath) as! PopupCell
        let item = items?[indexPath.row]
        cell.nameObj.text = item?.name
        if let img = item?.image {
            cell.imageObj.image = UIImage(named: img)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items?[indexPath.row]
        self.popupDelegate.selectedPopupWith(item: item!, parentCellIndex: referenceView!.tag, index: indexPath.row)
    }
}
