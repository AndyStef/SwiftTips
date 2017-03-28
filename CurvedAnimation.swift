class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let circleView = UIView()
        circleView.layer.masksToBounds = true
        circleView.backgroundColor = .green
        circleView.frame = CGRect(x: 0, y: 180, width: 30, height: 30)
        
        //Animation definition
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 1.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        circleView.layer.add(animation, forKey: nil)
        view.addSubview(circleView)
    }
}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200.0))
    let endPoint = CGPoint(x: 450.0, y: 200.0)
    let cp1 = CGPoint(x: 100.0, y: 100.0)
    let cp2 = CGPoint(x: 200.0, y: 350.0)
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    
    return path
}
