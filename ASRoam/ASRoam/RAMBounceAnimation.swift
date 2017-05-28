//
//  RAMBounceAnimation.swift
//  ATRoam
//
//  Created by Yanfei Yu on 2017/2/28.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import RAMAnimatedTabBarController



class RAMBounceAnimation : RAMItemAnimation {
    
    var textColor: UIColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 1)

    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textColor //textSelectedColor
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textColor //textSelectedColor
    }
    
    func playBounceAnimation(_ icon : UIImageView) {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}
