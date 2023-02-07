//
//  PopoverView.swift
//  Image Markup App
//
//  Created by Hamza Khalid on 06/02/2023.
//

import UIKit

protocol PopoverViewDelegate {
    
    func didTapCellOne(itemType:PopoverItem,value:Any)
    func didTapCellTwo(itemType:PopoverItem,value:Any)
    func didTapCellThree(itemType:PopoverItem,value:Any)
    
}

enum PopoverItem:String {
    
    case color = "Color"
    case penSize = "PenSize"
    case image = "Image"
}

class PopoverView: UIView {

    @IBOutlet weak var cellOneImageView: UIImageView!
    @IBOutlet weak var cellTwoImageView: UIImageView!
    @IBOutlet weak var cellThreeImageView: UIImageView!

    var delegate:PopoverViewDelegate?
    var itemType:PopoverItem?

    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
      //  setupViews()
    }
    
    private func loadNib() {
        let view = getNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
    }
    
    func prepareView(){
        
        setupPopoverItems(itemType: self.itemType ?? .color)
    }
    
    private func setupPopoverItems(itemType:PopoverItem){
        
        switch itemType {
        case .penSize:
            setPenSizeItem()
        case .image:
            setImageItem()
        default:
            setColorItem()
        }
    }
    
    private func setColorItem(){
        
        setCellOneImage(image: UIImage(systemName: "circle.fill") ?? UIImage())
        cellOneImageView.tintColor = .black
        setCellTwoImage(image: UIImage(systemName: "circle.fill") ?? UIImage())
        cellTwoImageView.tintColor = .red
        setCellThreeImage(image: UIImage(systemName: "circle.fill") ?? UIImage())
        cellThreeImageView.tintColor = .green
    }
    
    private func setPenSizeItem(){
     
        let thinImage = UIImage(systemName: "scribble", withConfiguration: UIImage.SymbolConfiguration(weight: .ultraLight)) ?? UIImage()
        setCellOneImage(image:thinImage)
        cellOneImageView.tintColor = .gray
        let mediumImage = UIImage(systemName: "scribble", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)) ?? UIImage()
        setCellTwoImage(image:mediumImage)
        cellTwoImageView.tintColor = .gray
        let heavyImage = UIImage(systemName: "scribble", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)) ?? UIImage()
        setCellThreeImage(image:heavyImage)
        cellThreeImageView.tintColor = .gray
        
    }
    
    private func setImageItem(){
        
    }
    
    private func getNib() -> UIView {
        let bundle = Bundle(for: PopoverView.self)
        let nib = UINib(nibName: "PopoverView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        
        return view
    }
    
    @IBAction func didTapCellOneButton(_ sender: Any) {
        self.delegate?.didTapCellOne(itemType: itemType ?? .color, value: getCellOneValue())
    }
    
    @IBAction func didTapCellTwoButton(_ sender: Any) {
        self.delegate?.didTapCellTwo(itemType: itemType ?? .color, value: getCellTwoValue())
    }
    
    @IBAction func didTapCellThreeButton(_ sender: Any) {
        self.delegate?.didTapCellThree(itemType: itemType ?? .color, value: getCellThreeValue())
    }
    
    private func setCellOneImage(image:UIImage){
        cellOneImageView.image = image
    }
    
    private func setCellTwoImage(image:UIImage){
        cellTwoImageView.image = image
    }
    
    private func setCellThreeImage(image:UIImage){
        cellThreeImageView.image = image
    }
    
    private func getCellOneValue() -> Any{
        
        switch itemType {
        case .penSize:
            return CGFloat(2)
        case .image:
            break
        default:
            return cellOneImageView.tintColor ?? .black
            
        }
        return ""
    }
    
    private func getCellTwoValue() -> Any{
        
        switch itemType {
        case .penSize:
            return CGFloat(4)
        case .image:
            break
        default:
            return cellTwoImageView.tintColor ?? .black
            
        }
        return ""
    }
    private func getCellThreeValue() -> Any{
        
        switch itemType {
        case .penSize:
            return CGFloat(6)
        case .image:
            break
        default:
            return cellThreeImageView.tintColor ?? .black
            
        }
        return ""
    }
}
