//
//  HorizontallyCollectionViewCell.swift
//  JTHorCollectionView
//
//  Created by Justin Tsou on 2019/4/30.
//  Copyright © 2019 iOSDeveloper. All rights reserved.
//

import UIKit

class HorizontallyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var horTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.horTextLabel.layer.masksToBounds = true
        self.horTextLabel.layer.borderWidth = 3.0
    }
    
    func setHorTextLabelTextColor(color:UIColor) {
         self.horTextLabel.textColor = color
    }
    
    func setHorTextLabelBorderColor(color:UIColor) {
        self.horTextLabel.layer.borderColor = color.cgColor
    }
}
