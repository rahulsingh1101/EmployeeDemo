

import UIKit

class EmployeeListViewCell: UITableViewCell {
    @IBOutlet var employeeName: UILabel!
    @IBOutlet var employeeSalary: UILabel!
    @IBOutlet var employeeAge: UILabel!
    @IBOutlet var settingsButtonObj: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
