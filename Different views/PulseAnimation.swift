import UIKit

class Pulsing: CALayer {
    
    var animationGroup = CAAnimationGroup()
    
    var initialPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 1.5
    var radius: Float = 200
    var numberOfPulses: Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(numberOfPulses: Float = Float.infinity, radius: Float, position: CGPoint) {
        super.init()
        self.numberOfPulses = numberOfPulses
        self.radius = radius
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.position = position
        self.bounds = CGRect(x: 0, y: 0, width: CGFloat(radius * 2), height: CGFloat(radius * 2))
        self.cornerRadius = CGFloat(radius)
        
        DispatchQueue.global(qos: .default).async {
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        self.animationGroup.timingFunction = defaultCurve
        
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
}



//ADD gesture to view that needs to emit pulses
 func handleTap() {
        let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: pulsingImage.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.blue.cgColor
        
        self.view.layer.insertSublayer(pulse, below: pulsingImage.layer)
    }
