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

//Трюк в тому: 
//1. Фіксуєм точку дотику на в'ю : 
//2. Від центру віднімаєм цю точку - touchOffset
//3.При переміщенні - зміщуєм центр на touchOffset (додаєм до точки переміщення на головнії в'ю)

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
        guard let point = touch?.location(in: view),
              let touchedView = view.hitTest(point, with: event) else { return }

        if !touchedView.isEqual(view) {
            draggingView = touchedView
            guard let touchPoint = touch?.location(in: draggingView),
                  let draged = draggingView else { return }
            view.bringSubview(toFront: draged)
            touchOffset = CGPoint(x: draged.bounds.midX - touchPoint.x,
                                  y: draged.bounds.midY - touchPoint.y)
        } else {
            draggingView = nil
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let draggingView = draggingView {
            let touch = touches.first
            guard let point = touch?.location(in: view),
                  let offset = touchOffset else { return }
            let correctPoint = CGPoint(x: point.x + offset.x,
                                       y: point.y + offset.y)
            draggingView.center = correctPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
