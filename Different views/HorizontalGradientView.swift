

@IBDesignable
class HorizontalGradientView: UIView {
    
    @IBInspectable  var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable  var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as? CAGradientLayer
        layer?.colors = [firstColor, secondColor].map{$0.cgColor}
        layer?.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer?.frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: 2)
    }
}
