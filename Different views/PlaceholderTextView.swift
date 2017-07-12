
@IBDesignable
class PlaceHolderTextView: UITextView {
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var placeholderText: String = "Placeholder" {
        didSet {
            placeholderLabel.text = placeholderText
        }
    }
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 16)
        
        addSubview(placeholderLabel)
        
        placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        placeholderLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
}





//MARK: - delegate method 
func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceHolderTextView else {
            return
        }
        
        if textView.text.isEmpty {
            textView.placeholderText = "Some placeholder text"
        } else {
            textView.placeholderText = ""
        }
    }
    
    
//MARK: - in viewDidLoadd
textView.delegate = self
textView.placeholderText = "Some placeholder"
textView.textColor = .black
