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
    func didTapPen()
    func didChangeColor(color:UIColor)
    func didChangePenSize(strokeSize:CGFloat,OutlineSize:CGFloat)
    
}
class EditViewController: UIViewController {
    
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var colorButton: UIView!
    @IBOutlet weak var arrowButton: UIView!
    @IBOutlet weak var undoButton: UIView!
    @IBOutlet weak var penSizeButton: UIView!
    @IBOutlet weak var penButton: UIView!
    @IBOutlet weak var colorButtonImageView: UIImageView!
    @IBOutlet var drawingViewContainer: UIView!
    
    @IBOutlet weak var arrowButtonImage: UIImageView!
    @IBOutlet weak var penButtonImage: UIImageView!
    var delegate: EditViewControllerDelegate?
    let drawingBoard = DrawingView()
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        drawingBoard.setupCanvasView()
    }
    
    private func prepareView(){
        setupDrawingBoard()
        penButtonImage.tintColor = .systemBlue
    }
    
    private func setupDrawingBoard(){
        
        drawingViewContainer.addSubview(drawingBoard)
        drawingBoard.pinToSuperViewEdges()
        drawingBoard.clipsToBounds = true
        drawingBoard.initializeView(parent: self)
        drawingBoard.delegate = self
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(drawingBoard.completedImage, nil, nil, nil)
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapPenSizeButton(_ sender: Any) {
        showPopOver(penSizeButton ?? UIView(), type: .penSize)
    }
    @IBAction func didTapUndoButton(_ sender: Any) {
        self.delegate?.didTapUndo()
    }
    @IBAction func didTapArrowButton(_ sender: Any) {
        
        arrowButtonImage.tintColor = .systemBlue
        penButtonImage.tintColor = .darkGray
        self.delegate?.didTapAddArrow()
    }
    @IBAction func didTapColorButton(_ sender: Any) {
        
        showPopOver(colorButton ?? UIView(), type: .color)
    }
    @IBAction func didTapPenButton(_ sender: Any) {
        
        penButtonImage.tintColor = .systemBlue
        arrowButtonImage.tintColor = .darkGray
        self.delegate?.didTapPen()
    }
    
}

extension EditViewController:UIPopoverPresentationControllerDelegate,PopoverViewDelegate,DrawingViewDelegate{
    
    func didDrawArrow() {
        self.arrowButtonImage.tintColor = .darkGray
    }
    
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
            let strokeSize = value as? CGFloat ?? 8
            let outlineSize = (value as? CGFloat ?? 8) + 4.0
            self.delegate?.didChangePenSize(strokeSize: strokeSize, OutlineSize: outlineSize)

        case .image:
            break
        default:
            self.delegate?.didChangeColor(color: value as? UIColor ?? .black)
            colorButtonImageView.tintColor = value as? UIColor
        }
        self.dismiss(animated: true)
    }
    
    
    func showPopOver(_ sender: Any,type:PopoverItem){
        
        let vc = PopoverViewController.instantiate(fromStoryboard: .Main)
        vc.parentController = self
        vc.itemType = type
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
