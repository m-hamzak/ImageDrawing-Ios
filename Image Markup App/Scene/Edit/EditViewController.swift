//
//  EditViewController.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 02/02/2023.
//

import UIKit

class EditViewController: UIViewController {
    
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var colorButton: UIView!
    @IBOutlet weak var arrowButton: UIView!
    @IBOutlet weak var undoButton: UIView!
    @IBOutlet weak var penSizeButton: UIView!
    @IBOutlet weak var colorButtonImageView: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapPenSizeButton(_ sender: Any) {
    }
    @IBAction func didTapUndoButton(_ sender: Any) {
    }
    @IBAction func didTapArrowButton(_ sender: Any) {
    }
    @IBAction func didTapColorButton(_ sender: Any) {
        if colorButtonImageView.tintColor == . red{
            
            colorButtonImageView.tintColor = .blue
        }else{
            colorButtonImageView.tintColor = .red
        }
    }
    
}
