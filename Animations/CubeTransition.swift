enum AnimationDirection: Int {
        case positive = 1
        case negative = -1
    }
    
    func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        //Creation of new label that has all properties as original label but its own text that will replace original
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = label.backgroundColor
        
        //Setting it to be much smaller than origin and above/below the origin
        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height/2.0
        auxLabel.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).translatedBy(x: 0.0, y: auxLabelOffset)
        label.superview!.addSubview(auxLabel)
        
        //animation itself
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            auxLabel.transform = .identity
            label.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).translatedBy(x: 0.0, y: -auxLabelOffset)
        }) { (_) in
            label.text = auxLabel.text
            label.transform = .identity
            auxLabel.removeFromSuperview()
        }
    }
    
    
    //Comment: this animation is specific and can be used only if start and changed text have same length
