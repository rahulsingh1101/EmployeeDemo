

import UIKit

protocol EmployeeListDelegate:class {
    func employeeSelected(_ employee: Employee?, onTap:UIButton)
}

class EmployeeListView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var employeeViewModelObj: EmployeeViewModel?{
        didSet{
            employeeViewModelObj?.refreshDelegate = self
            self.reloadData()
        }
    }
    
    weak var employeeDelegate: EmployeeListDelegate?
    
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
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(){
        self.delegate = self
        self.dataSource = self
        self.register(UINib.init(nibName: Identifiers.shared.employeeCellIdentifier, bundle: nil), forCellReuseIdentifier: Identifiers.shared.employeeCellIdentifier)
        self.backgroundColor = .clear
        self.tableFooterView = UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeViewModelObj?.numberOfRows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.shared.employeeCellIdentifier, for: indexPath) as! EmployeeListViewCell
        
        let employee = employeeViewModelObj?.modelAt(indexPath.row)
        cell.employeeName.text = employee?.employeeName
        cell.employeeSalary.text = employee?.employeeSalary
        cell.employeeAge.text = employee?.employeeAge
        
        cell.settingsButtonObj.tag = indexPath.row
        cell.settingsButtonObj.addTarget(self, action: #selector(self.settingsButtonAction(sender:)), for: .touchUpInside)

        return cell
    }
    
    @objc private func settingsButtonAction(sender: UIButton){
        let employee = employeeViewModelObj?.modelAt(sender.tag)        
        employeeDelegate?.employeeSelected(employee, onTap: sender)
    }
}

extension EmployeeListView: EmployeeViewModelCommunicatorDelegate{
    func refreshData() {
        self.reloadData()
    }
    
    
}
