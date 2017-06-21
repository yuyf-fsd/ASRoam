//
//  MineItemCell.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/20.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

class MineItemCell: UITableViewCell {
    @IBOutlet weak var mineItemImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
