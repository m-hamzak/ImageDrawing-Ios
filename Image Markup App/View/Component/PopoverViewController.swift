//
//  PopoverViewController.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 06/02/2023.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    var parentController:UIViewController?
    var itemType:PopoverItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXib()
        // Do any additional setup after loading the view.
    }
    
    
    func loadXib(){
        
        guard let customPopup = UINib(
                nibName: "PopoverView",
                bundle: Bundle(for: PopoverView.self)
        ).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        (customPopup as? PopoverView)?.delegate = parentController as? any PopoverViewDelegate
        (customPopup as? PopoverView)?.itemType = self.itemType
        (customPopup as? PopoverView)?.prepareView()
        customPopup.bounds = self.view.bounds
        customPopup.frame = self.view.frame
        self.view.addSubview(customPopup)
        self.popupView = customPopup
    }

}
