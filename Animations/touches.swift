//simple way to define if our touch get into right view
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let point = touch?.location(in: view) else { return }
        
        //test if we got into our specific view
        if testView.point(inside: point, with: event) {
            print("got it")
            print(point.x)
            print(point.y)
        }
    }
    
//--------------------------------Drag'n'drop with touches

import UIKit

class ViewController: UIViewController {

    let testView = UIView()
    var draggingView: UIView?
    var touchOffset: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 130, y: 100, width: 150, height: 150)
        testView.frame = rect
        testView.backgroundColor = .red
        view.addSubview(testView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let point = touch?.location(in: view) else { return }
        guard let touchedView = view.hitTest(point, with: event) else { return }
        
        if touchedView.isEqual(view) {
            print("touched self")
        } else {
            draggingView = touchedView
            guard let touchPoint = touch?.location(in: draggingView) else { return }
            touchOffset = CGPoint(x: draggingView?.bounds.midX ?? 0.0 - touchPoint.x,
                                  y: draggingView?.bounds.midY ?? 0.0 - touchPoint.y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let draggingView = draggingView {
            let touch = touches.first
            guard let point = touch?.location(in: view) else { return }
            let correctPoint = CGPoint(x: point.x + (touchOffset?.x ?? 20.0),
                                       y: point.y + (touchOffset?.y ?? 20.0))
            draggingView.center = correctPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touches ended")
        draggingView = nil
        touchOffset = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //that can be done with floor panel or with some gesture i guess
        print("touches canceled")
        draggingView = nil
        touchOffset = nil
    }
}
