//
//  CategoryCell.swift
//  eCommerce_RealmSwift
//
//  Created by Lakshmi on 02/09/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    @IBOutlet weak var categoryAmount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
