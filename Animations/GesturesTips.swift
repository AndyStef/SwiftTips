//1 
//Method tap.require(toFail: doubleTap) waits until other gesture fails 
//in order to do his own work(useful if we have 2 gestures applied to same object)

//2
//Single size scaling with taps 

func handleTap(tapGesture: UITapGestureRecognizer) {
        print(tapGesture.location(in: tapGesture.view))
        print(tapGesture.location(in: view))
        myView.backgroundColor = randomColor()
        
        let currentTransform = myView.transform
        let newTransform = currentTransform.scaledBy(x: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.2) { 
            self.myView.transform = newTransform
        }
    }
    
    func handleDoubleTap() {
        let currentTransform = myView.transform
        let newTransform = currentTransform.scaledBy(x: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.2) {
            self.myView.transform = newTransform
        }
    }
    
//3 
//scaling using pinch
//we store viewScale as property with 1.0 initial value
func handlePinch(pinchGesture: UIPinchGestureRecognizer) {
        //Якщо ми тільки почали зумити то кажем шо scale - початковий
        if pinchGesture.state == .began {
            viewScale = 1.0
        }
        
        //берем scale з жесту
        let scale = pinchGesture.scale
        //збільшуєм тільки на різницю
        let deltaScale = 1 + scale - viewScale
        let currentTransform = myView.transform
        let newTransform = currentTransform.scaledBy(x: deltaScale, y: deltaScale)
        myView.transform = newTransform
        //запам'ятовуєм новий scale, якщо жест ше не закінчився
        viewScale = scale
    }
    
 //4
 //rotation gesture 
 //pretty same but initial value is 0 
 func handleRotation(rotationGesture: UIRotationGestureRecognizer) {
        if rotationGesture.state == .began {
            viewRotation = 0.0
        }
        
        let rotation = rotationGesture.rotation
        let actualRotation = rotation - viewRotation
        let currentTransform = myView.transform
        let newTransform = currentTransform.rotated(by: actualRotation)
        myView.transform = newTransform
        viewRotation = rotation
    }
    
//5 
//in order to handle few gestures at same time we need delegate and 
//gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)


