//
//  UserInfoCell.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/20.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        //avatarImgView.layer.borderWidth = 1
        avatarImgView.layer.masksToBounds = true
        avatarImgView.layer.cornerRadius = 35
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
