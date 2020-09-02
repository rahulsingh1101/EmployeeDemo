

import UIKit

protocol EmployeeViewModelCommunicatorDelegate:class {
    func refreshData()
}

class EmployeeViewModel {
    private var employeeModels = [Employee]()
    weak var refreshDelegate: EmployeeViewModelCommunicatorDelegate?
    
    init(url: String, controller:UIViewController) {
        getEmployeesWith(url, controller: controller)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.employeeModels.count
    }
    
    func modelAt(_ index: Int) -> Employee {
        return self.employeeModels[index]
    }
    
    func removeItemAt(_ index: Int){
        self.employeeModels.remove(at: index)
        refreshDelegate?.refreshData()
    }
    
    func getEmployeesWith(_ url: String, controller:UIViewController){
        ServiceManager.shared.request(type: EmployeeData.self, url: url, method: .get, controller: controller) { (result) in
            if result != nil && result?.data?.count ?? 0 > 0 {
                DispatchQueue.main.async {
                    self.employeeModels = result!.data!
                    self.refreshDelegate?.refreshData()
                }
            }
        }
    }
    
}
