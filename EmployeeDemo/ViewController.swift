

import UIKit
import Alamofire

class ViewController: UIViewController {
    private var employeeViewModel = EmployeeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let employeeListViewObj = EmployeeListView()
        employeeListViewObj.employeeViewModelObj = self.employeeViewModel
        employeeListViewObj.employeeDelegate = self
        self.view.addAutolayoutSubview(employeeListViewObj)
        
        NSLayoutConstraint.activate([
            employeeListViewObj.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            employeeListViewObj.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            employeeListViewObj.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            employeeListViewObj.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.employeeViewModel.getEmployees(controller: self)
    }
}

extension ViewController: EmployeeListDelegate{
    func employeeSelected(_ employee: Employee?, onTap: UIButton) {
        let items:[Item] = [.init(name: "Edit", image: "edit"),
                            .init(name: "Remove", image: "delete"),
        ]
        _ = Popup(items: items, delegate: self, anchor: self.view, onButtonTouch: onTap as UIView)
    }
}

extension ViewController: PopupDelegate{
    func selectedPopupWith(item: Item, parentCellIndex: Int, index: Int) {
        if index == 1 {
            self.employeeViewModel.removeItemAt(parentCellIndex)
        }
    }
}

