//
//  Color.swift
//  LapsKit
//
//  Created by Buğra Ekuklu on 20.02.2016.
//  Copyright © 2016 The Digital Warehouse. All rights reserved.
//

import Foundation

struct Color {
    var red: Float = 0.00
    var green: Float = 0.00
    var blue: Float = 0.00
    var alpha: Float = 0.00
    
    init(red: Float, green: Float, blue: Float, alpha: Float) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}