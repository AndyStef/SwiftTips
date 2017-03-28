import UIKit

@IBDesignable
class RadialGradientView: UIView {
    @IBInspectable var insideColor: UIColor = UIColor.clear
    @IBInspectable var outsideColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        guard let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil) else { return }
        let endRadius = min(frame.width, frame.height) / 2
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let context = UIGraphicsGetCurrentContext()
        context?.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        //last param can be changed to be after start
    }
}
