private func observeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardShow() {
        UIView.animate(withDuration: 0.5) {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    func keyboardHide() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    
    func handleKeyboardShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
          let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
          print(keyboardFrame)
        }
    
  
    }
