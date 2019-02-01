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
        strokeLength = bd * speed + 0.001
        toX = _x + (Int)(strokeLength * cos(currentAngle))
        toY = _y + (Int)(strokeLength * sin(currentAngle))
        pos = CGPoint(x: _x, y: _y)
        
        let cpos = yPos % 10
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
        speed = speed + sp * (det(x1: _x, y1: _y, x2: previousX, y2: previousY, x3: x, y3: y) / (distance(x1: _x, y1: _y, x2: x, y2: y) + 1 ))
            previousX = x
            previousY = y
        }
        
        speed = speed * speedLimiter
        currentAngle = currentAngle + speed
        strokeLength = bd * speed + 1
        toX = _x + Int(strokeLength * cos(currentAngle)) + 1
        toY = _y + Int(strokeLength * sin(currentAngle)) + 1
        
    }
   
    func det(x1:Int,y1:Int,x2:Int,y2:Int,x3:Int,y3:Int) -> Float {
        return (Float) ((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1))
    }
 
    func distance(x1:Int,y1:Int,x2:Int,y2:Int) -> Float {
        let s1 = Float(x2-x1)
        let s2 = Float(x2-x1)
        let s3 = Float(y2-y1)
        let s4 = Float(y2-y1)
        return sqrtf( s1 * s2 + s3 * s4)
    }
    
}
