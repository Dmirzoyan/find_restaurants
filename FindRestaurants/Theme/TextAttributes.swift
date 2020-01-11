//
//  TextAttributes.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

struct TextAttributes {
    
    static var largeHeavy: [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    static var mediumLight: [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.font: UIFont(name: "ArialMT", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
