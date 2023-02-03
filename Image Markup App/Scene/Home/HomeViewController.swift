//
//  ViewController.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 02/02/2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapStartDrawing(_ sender: Any) {
        
        let vc = EditViewController.instantiate(fromStoryboard: .Main)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

