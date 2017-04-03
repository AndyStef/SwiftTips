class CircleView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        let radius = 100.0
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        path.move(to: CGPoint(x: Double(center.x) + radius, y: Double(center.y)))
        
        //By value needed to be change if we want to make it morre radial or with some parts
        for i in stride(from: 0, to: 370.0, by: 45) {
            
            let radians = i * Double.pi / 180
            
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
            path.addLine(to: CGPoint(x: x, y: y))
            
            
        }
        UIColor.green.setStroke()
        UIColor.blue.setFill()
        path.lineWidth = 5.0
        path.fill()
        path.stroke()
    }
}


let view = CircleView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.backgroundColor = .red
