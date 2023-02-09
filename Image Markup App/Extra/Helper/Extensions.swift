//
//  Extensions.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 08/02/2023.
//

import Foundation
import UIKit

extension UIBezierPath {
    
    func addArrow(start: CGPoint, end: CGPoint, pointerLineLength: CGFloat, arrowAngle: CGFloat) {
        
        let startPoint = calculateArrowStartPoint(start: start, end: end)
        self.move(to: startPoint)
        self.addLine(to: end)

        let startEndAngle = atan((end.y - startPoint.y) / (end.x - startPoint.x)) + ((end.x - startPoint.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))

        self.addLine(to: arrowLine1)
        self.move(to: end)
        self.addLine(to: arrowLine2)
    }
    
    func calculateArrowStartPoint(start: CGPoint, end: CGPoint) -> CGPoint{

        let d = sqrt(pow((end.x - start.x), 2) + pow((end.y - start.y), 2)) //distance
        let r = 100 / d //segment ratio

        let x3 = r * start.x + (1 - r) * end.x //find point that divides the segment
        let y3 = r * start.y + (1 - r) * end.y //into the ratio (1-r):r

        return CGPoint(x: x3, y: y3)
    }
}
