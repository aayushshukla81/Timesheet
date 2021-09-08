//
//  taskcell.swift
//  Timesheet
//
//  Created by hannan parvez on 03/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit

class taskcell: UITableViewCell {

    @IBOutlet var project: UILabel!
    @IBOutlet var task: UILabel!
    @IBOutlet var client: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
