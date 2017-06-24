//
//  BMCustomPlayer.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/24.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit
import BMPlayer

class BMCustomPlayer: BMPlayer {

    class override func storyBoardCustomControl() -> BMPlayerControlView? {
        return BMPlayerCustomControlView()
    }
}
