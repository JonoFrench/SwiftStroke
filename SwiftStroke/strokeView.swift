//
//  strokeView.swift
//  SwiftStroke
//
//  Created by Jonathan French on 28/01/2019.
//  Copyright © 2019 Jaypeeff. All rights reserved.
//

import UIKit

class strokeView: UIView {

    var cells = [Cell]()
    var numCells:Int = 5000
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var currentX:Int = 0
    var currentY:Int = 0
    var prevX:Int = 0
    var prevY:Int = 0
    var displayLink:CADisplayLink = CADisplayLink()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.frame = frame
        screenWidth = frame.width
        screenHeight = frame.height
        cells.reserveCapacity(numCells)
        
        for i in 0...numCells - 1 {
            let c:Cell = Cell()
            let a:Float = Float(i) + randomNumberBetween(0, and: Int(Double.pi / 9))
            var r:Float = Float(i) / Float(numCells) * Float((screenWidth / 2)) * ((Float(numCells)-Float(i)) / Float(numCells) * 3.5)
            r = r + randomNumberBetween(-3, and: 3) + 3
            let xp:Int = Int((r * cos(a)) + Float(screenWidth / 2))
            let yp:Int = Int((r * sin(a)) + Float(screenHeight / 2))
            c.initWithPosition(xPos: xp, yPos: yp)
            cells.append(c)
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(refreshDisplay))
        displayLink.add(to: .main, forMode:.common)
        self.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func randomNumberBetween( _ start: Int, and: Int) -> Float {
        let diff:Float = Float(and) - Float(start)
        return Float((Float(arc4random() / UInt32(RAND_MAX)) * diff) + Float(start) )
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPoint = touches.first?.location(in: touches.first?.view)
        let prevPoint = touches.first?.previousLocation(in: touches.first?.view)
        if let cp = currentPoint {
            currentX = Int(cp.x)
            currentY = Int(cp.y)
        }
        if let pp = prevPoint {
            prevX = Int(pp.x)
            prevY = Int(pp.y)
        }
        self.setNeedsDisplay()
    }
    
    @objc func refreshDisplay() {
        self.setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {

        for c in cells {
            c.sense(x: currentX, y: currentY, px: prevX, py: prevY)
            let aPath = UIBezierPath()
            aPath.move(to: c.pos)
            aPath.addLine(to: CGPoint(x: c.toX, y: c.toY))
            aPath.close()
            c.colour.setStroke()
            aPath.stroke()
        }
    }

}
