//
//  Cell.swift
//  SwiftStroke
//
//  Created by Jonathan French on 28/01/2019.
//  Copyright © 2019 Jaypeeff. All rights reserved.
//

import UIKit

class Cell: NSObject {

    var _x:Int = 0
    var _y:Int = 0
    var previousX:Int = 0
    var previousY:Int = 0
    var speed:Float = 0
    var currentAngle:Float = 0
    var bd:Float = 37
    var sp:Float = 0.004
    var speedLimiter:Float = 0.97
    var pos:CGPoint = CGPoint(x: 0, y: 0)
    var strokeLength:Float = 0
    var toX:Int = 0
    var toY:Int = 0
    var colour:UIColor = .white
    
    func initWithPosition(xPos:Int,yPos:Int) {
        _x = xPos
        _y = yPos
        strokeLength = 37.001
        toX = _x + (Int)(strokeLength * cos(currentAngle))
        toY = _y + (Int)(strokeLength * sin(currentAngle))
        pos = CGPoint(x: _x, y: _y)
        
        let cpos = (yPos + xPos) % 10
        switch cpos {
        case 0:
            colour = .white
            break
        case 1:
            colour = .red
            break
        case 2:
            colour = .yellow
            break
        case 3:
            colour = .blue
            break
        case 4:
            colour = .orange
            break
        case 5:
            colour = .green
            break
        case 6:
            colour = .purple
            break
        case 7:
            colour = .magenta
            break
        case 8:
            colour = .cyan
            break
        case 9:
            colour = .gray
            break
        default:
             colour = .white
        }
    }
    
    func sense(x:Int,y:Int,px:Int,py:Int) {
        if previousX != x || previousY != y {
            speed = speed + sp * (det(_x,_y,previousX,previousY,x,y) / (distance(_x,_y,x,y) + 1 ))
            previousX = x
            previousY = y
        }
        speed = speed * speedLimiter
        currentAngle = currentAngle + speed
        strokeLength = bd * speed + 1
        toX = _x + Int(strokeLength * cos(currentAngle)) + 1
        toY = _y + Int(strokeLength * sin(currentAngle)) + 1
    }
   
    var det = { (x1:Int,y1:Int,x2:Int,y2:Int,x3:Int,y3:Int) -> Float in
        return (Float) ((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1))
    }
    
    var distance = { (x1:Int,x2:Int,y1:Int,y2:Int) -> Float in
        let s1 = Float(x2-x1)
        let s2 = Float(y2-y1)
        return sqrtf((s1 * s1) + (s2 * s2))
    }
    
}
