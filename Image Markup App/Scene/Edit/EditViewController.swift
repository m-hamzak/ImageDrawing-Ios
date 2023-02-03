//
//  EditViewController.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 02/02/2023.
//

import UIKit


protocol EditViewControllerDelegate {
    
    func didTapUndo()
    func didTapAddArrow()
    func didTapChangeColor()
    func didTapPenSize()
    
}
class EditViewController: UIViewController {
    
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var colorButton: UIView!
    @IBOutlet weak var arrowButton: UIView!
    @IBOutlet weak var undoButton: UIView!
    @IBOutlet weak var penSizeButton: UIView!
    @IBOutlet weak var colorButtonImageView: UIImageView!
    @IBOutlet var drawingViewContainer: UIView!
    
    var delegate: EditViewControllerDelegate?
    let drawingBoard = DrawingView()
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        drawingViewContainer.addSubview(drawingBoard)
        drawingBoard.pinToSuperViewEdges()
        drawingBoard.initializeView(parent: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        drawingBoard.setupCanvasView()
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapPenSizeButton(_ sender: Any) {
        self.delegate?.didTapPenSize()
    }
    @IBAction func didTapUndoButton(_ sender: Any) {
        self.delegate?.didTapUndo()
    }
    @IBAction func didTapArrowButton(_ sender: Any) {
        self.delegate?.didTapAddArrow()
    }
    @IBAction func didTapColorButton(_ sender: Any) {
        
        if colorButtonImageView.tintColor == . red{
            
            colorButtonImageView.tintColor = .blue
        }else{
            colorButtonImageView.tintColor = .red
        }
        
        self.delegate?.didTapChangeColor()
    }
    
}
