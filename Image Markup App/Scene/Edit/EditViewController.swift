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
        
        showPopOver(colorButton)
       // self.delegate?.didTapChangeColor()
        
    }
    
}

extension EditViewController:UIPopoverPresentationControllerDelegate,PopoverViewDelegate{
    
    func didTapCellOne(itemType: PopoverItem, value: Any) {
        updateItemValue(itemType: itemType, value: value)
    }
    
    func didTapCellTwo(itemType: PopoverItem, value: Any) {
        updateItemValue(itemType: itemType, value: value)
    }
    
    func didTapCellThree(itemType: PopoverItem, value: Any) {
        updateItemValue(itemType: itemType, value: value)
    }
    
    private func updateItemValue(itemType: PopoverItem, value: Any){
        
        switch itemType {
        case .penSize:
            break
        case .image:
            break
        default:
            colorButtonImageView.tintColor = value as? UIColor
            drawingBoard.pen.setColor(color: value as? UIColor ?? .black)
        }
        self.dismiss(animated: true)
    }
    
    
    func showPopOver(_ sender: Any){
        
        let vc = PopoverViewController.instantiate(fromStoryboard: .Main)
        vc.parentController = self
        vc.preferredContentSize = CGSize(width: 50,height: 200)
                vc.modalPresentationStyle = .popover
                if let pres = vc.presentationController {
                    pres.delegate = self
                }
                self.present(vc, animated: true)
                if let pop = vc.popoverPresentationController {
                    pop.sourceView = (sender as! UIView)
                    pop.sourceRect = (sender as! UIView).bounds
                }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
