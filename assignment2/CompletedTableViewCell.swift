//
//  CompletedTableViewCell.swift
//  assignment2
//
//  Created by rk on 10/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class CompletedTableViewCell: UITableViewCell {

    @IBOutlet weak var dueOutlet: UILabel!
    @IBOutlet weak var descOutlet: UILabel!
    @IBOutlet weak var titleOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
