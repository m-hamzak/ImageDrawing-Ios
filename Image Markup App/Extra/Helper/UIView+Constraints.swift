//
//  UIView+Constraints.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 02/02/2023.
//

import UIKit

extension UIView {
    @discardableResult
    func pinToSuperViewEdges() -> [NSLayoutConstraint] {
        guard let superview = superview?.safeAreaLayoutGuide else { return [] }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        
        return constraints
    }
}
