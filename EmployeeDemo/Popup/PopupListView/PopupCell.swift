

import UIKit

class PopupCell: UITableViewCell {
    @IBOutlet var imageObj: UIImageView!
    @IBOutlet var nameObj: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
