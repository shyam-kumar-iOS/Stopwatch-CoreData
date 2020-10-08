//
//  EmployeeTblVCell.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 10/1/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class EmployeeTblVCell: UITableViewCell {

   
    @IBOutlet weak var imgV: UIImageView!
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var designationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
