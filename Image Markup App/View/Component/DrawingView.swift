//
//  DrawingView.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 02/02/2023.
//

import UIKit

protocol DrawingViewDelegate {
    func didDrawArrow()
}
class DrawingView: UIView {
    
    private var lastPoint: CGPoint = .zero
    private var currentPath = UIBezierPath()
    private var currentLayer: CAShapeLayer = CAShapeLayer()
    private let canvasView = UIView()
    private let mainImageView = UIImageView()
    private let pen = Pen()
    
    var completedImage = UIImage()
    var isDrawingArrow: Bool = false
    var testImage = UIImage()
    
    var parentController:UIViewController?
    var delegate:DrawingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [mainImageView, canvasView].forEach {
            addSubview($0)
//            $0.pinToSuperViewEdges()
                   }
        
        mainImageView.pinToSuperViewEdges()
        testImage = UIImage(named: "test2") ?? UIImage()
        
        self.mainImageView.image = testImage
        self.mainImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView(parent:UIViewController){
        self.parentController = parent
        (parentController as? EditViewController)?.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        lastPoint = touch.location(in: canvasView)
        //        if isDrawingArrow {
        currentLayer = CAShapeLayer()
        currentPath = UIBezierPath()
        canvasView.layer.addSublayer(currentLayer)
//    }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let currentPoint = touch.location(in: canvasView)
        if !isDrawingArrow {
            drawLine(from: lastPoint, to: currentPoint)
        }
        lastPoint = currentPoint
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: canvasView)
        // this is to make sure that when the user touches the screen again
        // He works on a new layer, this way we get one layer one drawing.
        
//        if !isDrawing, let layer = findLayer(in: touch) {
//            removeFromSuperLayer(from: layer)
//        }
        if isDrawingArrow{
            drawArrow(currentPoint: currentPoint)
        }
        // Create and image representation of all layers in tempImageView
        let renderer = UIGraphicsImageRenderer(bounds: canvasView.bounds)
        let image = renderer.image { rendererContext in
            
            canvasView.layer.render(in: rendererContext.cgContext)
        }
        
        // The resulting image of rendering all layers of `canvasView` is saved in temperory image variable
        
        completedImage = image
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        if canvasView.bounds.contains(fromPoint){

        currentPath.move(to: fromPoint)
        currentPath.addLine(to: toPoint)

        currentLayer.path = currentPath.cgPath
        currentLayer.backgroundColor = UIColor.red.cgColor
        currentLayer.strokeColor = pen.getColor().cgColor
        currentLayer.lineWidth = pen.getStrokeSize()
        currentLayer.lineCap = .round
        currentLayer.lineJoin = .round
 
    }
        
    }
    
    private func drawArrow(currentPoint:CGPoint){
        
        if canvasView.bounds.contains(currentPoint){
            let centrePoint = CGPoint(x: canvasView.bounds.midX, y: canvasView.bounds.midY)
            
            currentPath.addArrow(start: centrePoint, end: currentPoint, pointerLineLength: 30, arrowAngle: CGFloat(Double.pi / 4))
            currentLayer.strokeColor = pen.getColor().cgColor
            currentLayer.lineWidth = pen.getStrokeSize()
            currentLayer.path = currentPath.cgPath
            currentLayer.fillColor = UIColor.clear.cgColor
            currentLayer.lineJoin = .round
            currentLayer.lineCap = .round
            
            self.isDrawingArrow = false
            self.delegate?.didDrawArrow()
        }
    }
    
    private func findLayer(in touch: UITouch) -> CAShapeLayer? {
        let point = touch.location(in: canvasView)

        // check if any sublayers where added (drawings)
        guard let sublayers = canvasView.layer.sublayers else { return nil }

        for layer in sublayers {
            if let shapeLayer = layer as? CAShapeLayer,
               let outline = shapeLayer.path?.copy(strokingWithWidth: pen.getOutlineSize(), lineCap: .butt, lineJoin: .round, miterLimit: 0),
                outline.contains(point) == true {
                return shapeLayer
            }
        }
        
        return nil
    }
    
    private func removeFromSuperLayer(from layer: CALayer) {
        if layer != canvasView.layer {
            if let superLayer = layer.superlayer {
                removeFromSuperLayer(from: superLayer)
                layer.removeFromSuperlayer()
            }
        }
    }
}

extension DrawingView{
    
   private func setupImageLayer(){
        
        let myLayer = CALayer()
        myLayer.frame = canvasView.bounds
        myLayer.contents = testImage.cgImage
        canvasView.layer.addSublayer(myLayer)
    }
    
    func setupCanvasView(){
        
        let ratio = testImage.size.width / testImage.size.height
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        
        let newHeight = mainImageView.frame.size.width / ratio
        canvasView.frame.size = CGSize(width: mainImageView.frame.size.width, height: newHeight)
        canvasView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        canvasView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        canvasView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        setupImageLayer()
        
        // removing imageview to preserve memory
        mainImageView.removeFromSuperview()
        

    }
    
    private func removeLastLayer(){
        
        if  canvasView.layer.sublayers?.count ?? 1 > 1{
            
            canvasView.layer.sublayers?.removeLast()
        }
        
    }
    
    
//    private func addImageLayer(){
//
//        //let myLayer = CALayer()
//       // myLayer.frame = canvasView.bounds
//        imageLayer.contents = testImage.cgImage
//        imageLayer.frame.size = CGSize(width: 100, height: 100)
//        imageLayer.position = CGPointMake(canvasView.layer.bounds.midX, canvasView.layer.bounds.midY)
//        canvasView.layer.addSublayer(imageLayer)
//
//    }
}

extension DrawingView:EditViewControllerDelegate{
    
    func didChangeColor(color: UIColor) {
        self.pen.setColor(color: color)
    }
    
    func didChangePenSize(strokeSize: CGFloat, OutlineSize: CGFloat) {
        self.pen.setStrokeSize(size: strokeSize)
        self.pen.setOutlineSize(size: OutlineSize)
    }
    
    
    func didTapUndo() {
        removeLastLayer()
    }
    
    func didTapAddArrow() {
        self.isDrawingArrow = true
    }
    

}
