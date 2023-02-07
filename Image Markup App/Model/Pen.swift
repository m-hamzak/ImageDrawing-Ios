//
//  Pen.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 07/02/2023.
//

import Foundation
import UIKit

class Pen {
    
    var color:UIColor
    var strokeSize:CGFloat
    var outlineSize:CGFloat
    
    init() {
        self.color = .black
        self.strokeSize = 8
        self.outlineSize = 12
    }
    
    func getColor() -> UIColor{
        return self.color
    }
    
    func getStrokeSize() -> CGFloat{
        return self.strokeSize
    }
    
    func getOutlineSize() -> CGFloat{
        return self.outlineSize
    }
    
    func setColor(color:UIColor){
        self.color = color
    }
    
    func setStrokeSize(size:CGFloat){
        self.strokeSize = size
    }
    
    func setOutlineSize(size:CGFloat){
        self.outlineSize = size
    }
    
}
