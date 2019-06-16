//
//  Animations sample.swift
//  NetworkLayer
//
//  Created by Andriy Stefanchuk on 6/4/19.
//  Copyright © 2019 AS. All rights reserved.
//

import UIKit

// UIKIT ANIMATIONS

// Every object inherited from UIView is animatable
// Appearance animation can be prepared inside viewWillAppear() -> All views are on the screen

// 1. Simple UIView.animate animation - UIView.animate()
// 2. Spring UIView.animate()
// 3. Transitions - with, from - to
// 4. Keyframe animations
// 5. Animating constraints
// 6. Layer animations - CABasicAnimation
// 7. Layer animations delegates
// 8. Layer animations keys
// 9. Animation groups - CAAnimationGroup
// 10. Layer springs - CASpringAnimation
// 11. Layer keyframe animations - CAKeyframeAnimation
// 12. Struct values setting
// 13. Shape layer animations
// 14. Particle emitters - CAEmitterLayer
// 15. Frame animation with UIImageView
// 16. Gradient animations
// 17. Stroke and path animations - Keyframe animation + path + strokeStart + strokeEnd
// 18. Replicating animations - CAReplicationLayer      (NOT COVERED YET)
// 19. Custom presentation controllers (transitions)
// 20. Device orientation transition
// 21. UINavigationController custom transition         (NOT COVERED YET)
// 22. Interactive UINavigationController transitions   (NOT COVERED YET)
// 23. UIVIewPropertyAnimator
// 24. UIVIewPropertyAnimator interactive animations
// 25. 3d animations

let testView = UIView()

// MARK: - 1. Simple UIView.animate animation

func simpleUIViewAnimationSample() {
    UIView.animate(withDuration: 0.3) {
        testView.center.x += 50
        testView.backgroundColor = .red
        testView.transform = CGAffineTransform(rotationAngle: 20.0)
    }

    // Delay - timeInterval after which animation is executed

    // Options:
    // - autoreverse - create animation which is symetric to the original
    // - repeat - repeat animation (infinity)
    // - curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear
    // - transitionCrossDissolve, transitionCurlDown, transitionCurlUp, transitionFlipFromBottom, transitionFlipFromLeft, transitionFlipFromRight, transitionFlipFromTop - change of property with some visual change like new animation - used for transitions

    // Completion - A code closure to execute when the animation completes. This parameter often comes in handy when you want to perform some final cleanup tasks or chain animations one after the other.
    UIView.animate(withDuration: 0.3, delay: 0.3, options: [.autoreverse, .repeat], animations: {
        testView.center.x += 50
    }, completion: nil)

    // What can be animated:
    // Position and size - bounds, frame, size
    // Appearance - backgroundColor, alpha,
    // Transform: Rotation, size, translation
}

// MARK: -  2. Spring

func springAnimations() {
    // Damping - This controls the amount of damping, or reduction, applied to the animation as it approaches its final state. This parameter accepts values between 0.0 and 1.0. Values closer to 0.0 create a bouncier animation, while values closer to 1.0 create a stiff-looking effect. You can think of this value as the “stiffness” of the spring
    // Damping - stiffness - жорсткість - те, як пружина поводить себе вкінці
    // Velocity - This controls the initial velocity of the animation. A value of 1.0 sets the velocity of the animation to cover the total distance of the animation in the span of one second. Bigger and smaller values will cause the animation to have more or less velocity.
    // Velocity - початкова швидкість
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 20, options: [], animations: {
        testView.center.x += 50
    }, completion: nil)
}

// MARK: - 3. Transitions - with, from - to

func transitionsSample() {
    let animationContainer = UIView()

    // Add new view to hierarchy with animation
    UIView.transition(with: animationContainer, duration: 0.3,
                      options: [.transitionFlipFromTop],
                      animations: {
                          animationContainer.addSubview(testView)
    }, completion: nil)

    // Removes view from hierarchy with animation
    UIView.transition(
        with: animationContainer, duration: 0.33,
        options: [.transitionFlipFromLeft, .curveEaseOut],
        animations: {
            testView.removeFromSuperview()
        },
        completion: nil
    )

    // Hides view from hierarchy with animation
    UIView.transition(
        with: animationContainer, duration: 0.33,
        options: [.transitionFlipFromLeft, .curveEaseOut],
        animations: {
            testView.isHidden = true
        },
        completion: nil
    )

    let newView = UIView()

    // Changes one view to another
    UIView.transition(
        from: testView, to: newView,
        duration: 0.33, options: [.transitionCurlDown]
    ) { _ in
        print("Yeah!")
        // can remove old view here
    }

    // UIView.transition(with) can be used to effectively change UIImageView.image
}

// MARK: - 4. Keyframe animations

func keyframeSample() {
    // UIViewKeyframeAnimationOptions - to investigate

    let planeImage = UIImageView()
    let originalCenter = planeImage.center

    UIView.animateKeyframes(
        withDuration: 4.0, delay: 0.3, options: [],
        animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                planeImage.center.x += 80.0
                planeImage.center.y -= 10.0
            })

            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                planeImage.center.x += 100.0
                planeImage.center.y -= 50.0
                planeImage.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                planeImage.transform = .identity
                planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                planeImage.alpha = 1.0
                planeImage.center = originalCenter
            }
        }, completion: nil
    )
}

// MARK: -  5. Animating constraints

func animateConstraints() {
    let someConstraint = NSLayoutConstraint(item: testView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 20.0)
    someConstraint.constant = 60

    UIView.animate(withDuration: 0.3) {
        // Actually it has to be view of VC
        testView.layoutIfNeeded()
    }
}

// MARK: - View VS Layer

// Layer is just a model class which is responsible for displaying view
// Layer is just an image
// Layer has no autolayout
// Layers are drown directly on GPU
//
// Views gives us user interaction (UIResponder subclass)
// Complex view hierarchy layouts, autolayout
// very flexible, powerful
// often have custom logic or custom drawng code that executes on main thread on the CPU

// MARK: - 6. Layer animations - CABasicAnimation

// • Basic movement, fading, rotation, and scaling animations
// • Groups and keyframe animations
// • Shapes, masks, and gradient animations
// • Stroke and path animations

func testCALayerAnimations() {
    // What is animatable in layers?
    // Position and size: bounds, position, transform
    // Border: borderColor, borderWidth, cornerRadius
    // Shadow: shadowOffset, shadowOpacity, shadowPath, shadowRadius
    // Contenets: contents, mask, opacity

    let view = UIView()
    let headingView = UIView()

    // That's model object that can be reused
    let flyRight = CABasicAnimation(keyPath: "position.x")
    flyRight.fromValue = -view.bounds.size.width / 2
    flyRight.toValue = view.bounds.size.width / 2
    flyRight.duration = 0.5
    flyRight.beginTime = CACurrentMediaTime() + 0.3 // delay
    flyRight.fillMode = CAMediaTimingFillMode.both
    flyRight.isRemovedOnCompletion = true
    // forKey is used to remember animation and later on gives possibility to change it or cancel
    // add(, forKey) makes copy of the animation object
    headingView.layer.add(flyRight, forKey: nil)

    // fillMode allows to control behavior of animation at the beginning and end of its sequence
    // kCAFillModeRemoved(default)
    // starts the animation at the defined beginTime — or instantly, if you haven’t set beginTime — and removes the changes made during the animation when the animation completes
    // kCAFillModeBackwards
    // displays the first frame of your animation instantly on the screen, regardless of the actual start time of the animation, and starts the animation at a later time
    // kCAFillModeForwards
    // plays the animation as usual, but retains the final frame of the animation on the screen until you remove the animation
    // kCAFillModeBoth
    // combination of kCAFillModeForwards and kCAFillModeBackwards; as you’d expect, this makes the first frame of the animation appear on the screen immediately and retains the final frame on the screen when the animation is finished

    flyRight.delegate = LayerAnimationDelegate()
    flyRight.setValue("form", forKey: "name")
    flyRight.setValue(headingView.layer, forKey: "layer")
}

// MARK: - Animation VS Real content

// When animation is happening - we don't see actual view - we just see cached version of presentation layer
// The presentation layer is removed from the screen when animation is done and original is shown again
// When animation starts - presentation layer is created and original view is hidden for the time of animation
// isRemovedOnCompletion - defines if this presentation layer is removed and destroyed after animation is completed
// As a rule of thumb: remove your animations and consider never using fillMode, except if the effect you want to achieve is not possible otherwise. fillMode makes your UI elements lose their interactivity and also makes the screen not reflect the actual values in your layer object.
// In some rare cases when you animate non-interactive visual elements fillMode will save your bacon
// As for updating your layer properties: consider always doing that immediately after you add the animation to your layer.

// MARK: - 7. Layer animations delegates

class LayerAnimationDelegate: NSObject, CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("Did started")

        guard let name = anim.value(forKey: "name") as? String else {
            return
        }

        if name == "form" {
            // Do some stuff with form animation
        }
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Did finished")

        guard let name = anim.value(forKey: "name") as? String else {
            return
        }

        if name == "form" {
            let layer = anim.value(forKey: "layer") as? CALayer
            anim.setValue(nil, forKey: "layer")

            let pulse = CABasicAnimation(keyPath: "transform.scale")
            pulse.fromValue = 1.25
            pulse.toValue = 1.0
            pulse.duration = 0.25
            layer?.add(pulse, forKey: nil)
        }
    }
}

// MARK: - 8. Layer animations keys

func layerKeysSample() {
    let info = UILabel()

    let flyLeft = CABasicAnimation(keyPath: "position.x")
    flyLeft.fromValue = info.layer.position.x + testView.frame.size.width
    flyLeft.toValue = info.layer.position.x
    flyLeft.duration = 5.0
    info.layer.add(flyLeft, forKey: "infoappear")

    let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
    fadeLabelIn.fromValue = 0.2
    fadeLabelIn.toValue = 1.0
    fadeLabelIn.duration = 4.5
    info.layer.add(fadeLabelIn, forKey: "fadein")

    guard let runningAnimations = info.layer.animationKeys() else {
        return
    }

    // Stops and removes all animations from layer
    info.layer.removeAllAnimations()

    // Single removal of animation
    info.layer.removeAnimation(forKey: "fadein")
}

// MARK: - 9. Animation groups - CAAnimationGroup

func animationGroupsTest() {
    let groupAnimation = CAAnimationGroup()
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5
    groupAnimation.duration = 0.5
    groupAnimation.fillMode = CAMediaTimingFillMode.backwards
    groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
    groupAnimation.repeatCount = 4
    groupAnimation.autoreverses = true
    groupAnimation.speed = 2.0

    testView.layer.speed = 2.0 // make all animations on this layer with this speed
    // this works as multiplication = groupAnimationSpeed = 2 * 2 = 4

    groupAnimation.repeatDuration = 4.0 // can be used instead of repeatCount

    let scaleDown = CABasicAnimation(keyPath: "transform.scale")
    scaleDown.fromValue = 3.5
    scaleDown.toValue = 1.0

    let rotate = CABasicAnimation(keyPath: "transform.rotation")
    rotate.fromValue = .pi / 4.0
    rotate.toValue = 0.0

    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 0.0
    fade.toValue = 1.0

    groupAnimation.animations = [scaleDown, rotate, fade]
    testView.layer.add(groupAnimation, forKey: nil)
}

// CA animations easing functions
// kCAMediaTimingFunctionLinear
// kCAMediaTimingFunctionEaseIn
// kCAMediaTimingFunctionEaseOut
// kCAMediaTimingFunctionEaseInEaseOut
// Custom timing function

// MARK: - 10. Layer springs

// damping: This is due to air friction, mechanical friction and other external slowing forces acting on the system
// Damping - stiffness - жорсткість - те, як пружина поводить себе вкінці
// mass: The heavier the pendulum, the greater the length of time it will swing
// stiffness: The stiffer the “spring” of the oscillator, which in this case is Earth’s gravity, the harder the pendulum will swing at first, and the faster the system will settle down. Imagine if you were to use this pendulum on the moon or on Jupiter; the movements in low and high gravity situations would be quite different
// initial velocity: Did your grandpa simply let the pendulum go, or did he give the pendulum a push

// UIKit VS CA - time of UIKit animation is forced and not natural
// CA time is dependent on all parameters and animation duration is unpredictable

func testLayerSprings() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.fromValue = 1.25
    pulse.toValue = 1.0
    pulse.duration = pulse.settlingDuration
    pulse.damping = 7.5 // 10.0 default
    pulse.initialVelocity = 100.0 // 0.0 default
    pulse.mass = 10.0 // 1.0 default
    pulse.stiffness = 1500.0 // 100.0 default
    testView.layer.add(pulse, forKey: nil)
}

// MARK: - 11. Layer keyframe animations

// View keyframe animations are a simple way to combine independent simple animations together
// Layer keyframe animation let us animate only one property on a given layer
// You can define different key points of animation, but you can't have any gaps or overlaps in animation
// Instead of from and to values we have values array
// Keytimes define when values are changed

func testKeyframeAnimations() {
    let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
    wobble.duration = 0.25
    wobble.repeatCount = 4
    wobble.values = [0.0, -.pi / 4.0, 0.0, .pi / 4.0, 0.0]
    wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
    testView.layer.add(wobble, forKey: nil)
}

// MARK: - 12. Struct values setting

// Core Animation is an Objective-C framework built on C
// Cocoa includes the NSValue class, which “boxes in” or “wraps” a struct value as an object
// init(cgPoint: CGPoint)
// init(cgSize: CGSize)
// init(cgRect rect: CGRect)
// init(caTransform3D: CATransform3D)

func testStructValuesSetting() {
    let move = CABasicAnimation(keyPath: "position")
    move.duration = 1.0
    move.fromValue = NSValue(cgPoint: CGPoint(x: 100.0, y: 100.0))
    move.toValue = NSValue(cgPoint: CGPoint(x: 200.0, y: 200.0))

    let balloon = CALayer()
    balloon.contents = UIImage(named: "balloon")!.cgImage
    balloon.frame = CGRect(x: -50.0, y: 0.0, width: 50.0, height: 65.0)
    testView.layer.insertSublayer(balloon, below: testView.layer)

    let flight = CAKeyframeAnimation(keyPath: "position")
    flight.duration = 12.0
    flight.values = [
        CGPoint(x: -50.0, y: 0.0),
        CGPoint(x: testView.frame.width + 50.0, y: 160.0),
        CGPoint(x: -50.0, y: testView.center.y),
    ].map { NSValue(cgPoint: $0) }
    flight.keyTimes = [0.0, 0.5, 1.0]
}

// MARK: - 13. Shape layer animations

// Instead of taking in drawing instructions, you give a the CALayer a CGPath to draw on screen
// If you’re more familiar with UIBezierPath, you can use that to define a shape and then use its cgPath property to get its Core Graphics representation

// • path: Morph the layer’s shape into a different shape.
// • fillColor: Change the fill tint of shape to a different color.
// • lineDashPhase: Create a marquee or “marching ants” effect around your shape.
// • lineWidth: Grow or shrink the size of the stroke line of your shape.

func testShapeAnimations() {
    testView.layer.mask = CAShapeLayer() // Some mask layers should go here

    let morphedFrame = CGRect(x: 0, y: 10, width: 2, height: 34)

    let morphAnimation = CABasicAnimation(keyPath: "path")
    morphAnimation.duration = 0.5
    morphAnimation.toValue = UIBezierPath(ovalIn:
        morphedFrame).cgPath
    morphAnimation.timingFunction = CAMediaTimingFunction(
        name: CAMediaTimingFunctionName.easeOut
    )
    testView.layer.add(morphAnimation, forKey: nil)
}

// MARK: - 14. Particle emitters

// https://medium.com/@peteliev/what-do-you-know-about-caemitterlayer-368378d45c2e
// https://developer.apple.com/documentation/quartzcore/caemitterlayer
// https://medium.com/@vialyx/import-coreanimation-create-cool-visual-effect-using-caemitterlayer-with-swift-343ddd5a6009

func testEmmiterLayer() {
    let rect = CGRect(x: 0.0, y: 100.0, width: testView.bounds.width, height: 50.0)
    let emitter = CAEmitterLayer()
    emitter.frame = rect
    emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    // point shape - good for effects like fireworks
    // line shape - good for waterfall effects
    // rectangle shape - points are generated in given frame
    // cuboid, circle, sphere
    emitter.emitterPosition = CGPoint(x: 100.0, y: 100.0)
    emitter.emitterSize = CGSize(width: 100, height: 200)
    // shape, position and size defines emiiter frame

    let emitterCell = CAEmitterCell()
    emitterCell.contents = UIImage(named: "flake.png")?.cgImage
    emitterCell.birthRate = 20
    emitterCell.lifetime = 3.5
    emitterCell.lifetimeRange = 1.0
    emitterCell.yAcceleration = 70.0
    emitterCell.xAcceleration = 10.0

    emitterCell.velocity = 20.0
    emitterCell.emissionLongitude = .pi * -0.5 // To investigate
    emitterCell.emissionRange = .pi * 0.5
    emitterCell.velocityRange = 200.0 // Some randomness for particles - angle of creation

    // Can also set one color
    emitterCell.redRange = 0.3
    emitterCell.greenRange = 0.3
    emitterCell.blueRange = 0.3

    emitterCell.scale = 0.8
    emitterCell.scaleRange = 0.8

    emitterCell.scaleSpeed = -0.15
    emitterCell.alphaRange = 0.75
    emitterCell.alphaSpeed = -0.15

    emitter.emitterCells = [emitterCell]

    testView.layer.addSublayer(emitter)
}

// MARK: - 15. Frame animation with UIImageView

func testFrameAnimation() {
    let penguin = UIImageView()
    penguin.animationImages = [UIImage]()
    penguin.animationDuration = 30.0 / 3
    penguin.animationRepeatCount = 3
    penguin.startAnimating()
    _ = penguin.isAnimating
    penguin.stopAnimating()
}

// MARK: - 16. Gradient animations

func testGradientAnimation() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    let colors = [UIColor.black, UIColor.white, UIColor.black].map { $0.cgColor }
    gradientLayer.colors = colors
    let locations: [NSNumber] = [0.25, 0.5, 0.75]
    gradientLayer.locations = locations
    testView.layer.addSublayer(gradientLayer)

    let gradientAnimation = CABasicAnimation(keyPath: "locations")
    gradientAnimation.fromValue = [0.0, 0.0, 0.25]
    gradientAnimation.toValue = [0.75, 1.0, 1.0]
    gradientAnimation.duration = 3.0
    gradientAnimation.repeatCount = Float.infinity
    gradientLayer.add(gradientAnimation, forKey: nil)
}

func gradientWithTextMask() {
    let textAttributes: [NSAttributedString.Key: Any] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [
            NSAttributedString.Key.font: UIFont(
                name: "HelveticaNeue-Thin",
                size: 28.0
            )!,
            NSAttributedString.Key.paragraphStyle: style,
        ]
    }()

    let attributedString = NSAttributedString(string: "Test")
    let image = UIGraphicsImageRenderer(size: testView.bounds.size)
        .image { _ in
            attributedString.draw(in: testView.bounds)
        }

    let maskLayer = CALayer()
    maskLayer.backgroundColor = UIColor.clear.cgColor
    maskLayer.frame = testView.bounds.offsetBy(dx: testView.bounds.size.width, dy: 0)
    maskLayer.contents = image.cgImage

    let gradientLayer = CAGradientLayer()
    gradientLayer.mask = maskLayer
}

// TODO: - 17. Stroke and path animations

func testStrokeAnimation() {
    let ovalShapeLayer = CAShapeLayer()
    ovalShapeLayer.strokeColor = UIColor.white.cgColor
    ovalShapeLayer.fillColor = UIColor.clear.cgColor
    ovalShapeLayer.lineWidth = 4.0
    ovalShapeLayer.lineDashPattern = [2, 3] //  array with the length of the dash and the length of the gap in pixels

    let refreshRadius = testView.frame.size.height / 2 * 0.8

    ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(
        x: testView.frame.size.width / 2 - refreshRadius,
        y: testView.frame.size.height / 2 - refreshRadius,
        width: 2 * refreshRadius,
        height: 2 * refreshRadius
    )).cgPath
    testView.layer.addSublayer(ovalShapeLayer)

    // redrawFromProgress()
    // This can be used to animate progress
    ovalShapeLayer.strokeEnd = 20.0 // progress

    let airplaneImage = UIImage(named: "airplane.png")!
    let airplaneLayer = CAShapeLayer()
    airplaneLayer.contents = airplaneImage.cgImage
    airplaneLayer.bounds = CGRect(x: 0.0, y: 0.0,
                                  width: airplaneImage.size.width,
                                  height: airplaneImage.size.height)
    airplaneLayer.position = CGPoint(
        x: testView.frame.size.width / 2 + testView.frame.size.height / 2 * 0.8,
        y: testView.frame.size.height / 2
    )
    testView.layer.addSublayer(airplaneLayer)

    let strokeStartAnimation = CABasicAnimation(
        keyPath: "strokeStart"
    )
    strokeStartAnimation.fromValue = -0.5
    strokeStartAnimation.toValue = 1.0
    let strokeEndAnimation = CABasicAnimation(
        keyPath: "strokeEnd"
    )
    strokeEndAnimation.fromValue = 0.0
    strokeEndAnimation.toValue = 1.0

    let strokeAnimationGroup = CAAnimationGroup()
    strokeAnimationGroup.duration = 1.5
    strokeAnimationGroup.repeatDuration = 5.0
    strokeAnimationGroup.animations =
        [strokeStartAnimation, strokeEndAnimation]
    ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)

    // Flight and path animation
    let flightAnimation = CAKeyframeAnimation(keyPath: "position")
    flightAnimation.path = ovalShapeLayer.path
    flightAnimation.calculationMode = CAAnimationCalculationMode.paced
    // flightAnimation.rotationMode = ...

    let airplaneOrientationAnimation = CABasicAnimation(keyPath:
        "transform.rotation")
    airplaneOrientationAnimation.fromValue = 0
    airplaneOrientationAnimation.toValue = 2.0 * .pi

    let flightAnimationGroup = CAAnimationGroup()
    flightAnimationGroup.duration = 1.5
    flightAnimationGroup.repeatDuration = 5.0
    flightAnimationGroup.animations = [flightAnimation, airplaneOrientationAnimation]
    airplaneLayer.add(flightAnimationGroup, forKey: nil)
}

// TODO: - 18. Replicating animations - CAReplicationLayer

// Idea of replicating layer - you create some content - shape, image, everything that you can create with layers
// Replication animation properties
// • instanceCount
// • instanceTransform - Change the transform between replications on the fly
// • instanceDelay - Animate the amount of delay between instances
// • instanceColor - Change the blend color used for all instances
// • instanceRedOffset, instanceGreenOffset, instanceBlueOffset - Apply a delta to apply to each instance color component
// • instanceAlphaOffset - Change the opacity delta applied to each instance

func testReplicationLayerAnimations() {
    let replicator = CAReplicatorLayer()
    let dot = CALayer()
    let dotLength: CGFloat = 6.0
    let dotOffset: CGFloat = 8.0

    // It should be done with VC main view
    replicator.frame = testView.bounds
    testView.layer.addSublayer(replicator)

    dot.frame = CGRect(
        x: replicator.frame.size.width - dotLength,
        y: replicator.position.y,
        width: dotLength, height: dotLength
    )
    dot.backgroundColor = UIColor.lightGray.cgColor
    dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
    dot.borderWidth = 0.5
    dot.cornerRadius = 1.5

    replicator.addSublayer(dot)

    replicator.instanceCount = Int(testView.frame.size.width / dotOffset)
    replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0.0, 0.0)
    replicator.instanceDelay = 0.02

    let move = CABasicAnimation(keyPath: "position.y")
    move.fromValue = dot.position.y
    move.toValue = dot.position.y - 50.0
    move.duration = 1.0
    move.repeatCount = 10
    dot.add(move, forKey: nil)

    let scale = CABasicAnimation(keyPath: "transform")
    scale.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
    scale.toValue = NSValue(caTransform3D:
        CATransform3DMakeScale(1.4, 15, 1.0))
    scale.duration = 0.33
    scale.repeatCount = .infinity
    scale.autoreverses = true
    scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    dot.add(scale, forKey: "dotScale")
    
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 1.0
    fade.toValue = 0.2
    fade.duration = 0.33
    fade.beginTime = CACurrentMediaTime() + 0.33
    fade.repeatCount = .infinity
    fade.autoreverses = true
    fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    dot.add(fade, forKey: "dotOpacity")
    
    let tint = CABasicAnimation(keyPath: "backgroundColor")
    tint.fromValue = UIColor.magenta.cgColor
    tint.toValue = UIColor.cyan.cgColor
    tint.duration = 0.66
    tint.beginTime = CACurrentMediaTime() + 0.28
    tint.fillMode = CAMediaTimingFillMode.backwards
    tint.repeatCount = .infinity
    tint.autoreverses = true
    tint.timingFunction = CAMediaTimingFunction(name:
        CAMediaTimingFunctionName.easeInEaseOut)
    dot.add(tint, forKey: "dotColor")
    
    let initialRotation = CABasicAnimation(keyPath:
        "instanceTransform.rotation")
    initialRotation.fromValue = 0.0
    initialRotation.toValue   = 0.01
    initialRotation.duration = 0.33
    initialRotation.isRemovedOnCompletion = false
    initialRotation.fillMode = CAMediaTimingFillMode.forwards
    initialRotation.timingFunction = CAMediaTimingFunction(name:
        CAMediaTimingFunctionName.easeOut)
    replicator.add(initialRotation, forKey: "initialRotation")
    
    let rotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
    rotation.fromValue = 0.01
    rotation.toValue   = -0.01
    rotation.duration = 0.99
    rotation.beginTime = CACurrentMediaTime() + 0.33
    rotation.repeatCount = .infinity
    rotation.autoreverses = true
    rotation.timingFunction = CAMediaTimingFunction(name:
        CAMediaTimingFunctionName.easeInEaseOut)
    replicator.add(rotation, forKey: "replicatorRotation")
}

// MARK: - 19. Custom presentation controllers (transitions)

class MainViewController: UIViewController {
    let transition = AdvancedPopAnimator()
    let selectedImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        transition.dismissCompletion = {
            self.selectedImage.isHidden = false
        }
    }

    func presentDetailController() {
        let vc = UIViewController()
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = selectedImage.superview?.convert(selectedImage.frame, to: nil) ?? .zero
        transition.presenting = true
        selectedImage.isHidden = true
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

class PopAnimatior: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        let toView = transitionContext.view(forKey: .to)!
        containerView.addSubview(toView) // how it adds this subview ?? (in scope of layout)
        toView.alpha = 0.0
        UIView.animate(
            withDuration: duration,
            animations: {
                toView.alpha = 1.0
            }
        ) { _ in
            transitionContext.completeTransition(true)
        }
    }
}

class AdvancedPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!

        // Herb view is detail view
        // In every case this view will be animated
        // when presenting - it will grow up to tale whole screen
        // when dismissing - it will shrink to the original size
        let herbView = presenting ? toView : transitionContext.view(forKey: .from)!

        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        let xScaleFactor = presenting
            ? initialFrame.width / finalFrame.width
            : finalFrame.width / initialFrame.width

        let yScaleFactor = presenting
            ? initialFrame.height / finalFrame.height
            : finalFrame.height / initialFrame.height

        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            herbView.clipsToBounds = true
        }

        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }

            transitionContext.completeTransition(true)
        }
    }
}

// MARK: - 20. Device orientation transition

class OrientationTest: UIViewController {
    private let bgImage = UIImageView()

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.bgImage.alpha = (size.width > size.height) ? 0.25 : 0.55
        }, completion: nil)
    }
}

// TODO: - 21. UINavigationController custom transition

// TODO: - 22. Interactive UINavigationController transitions

// MARK: - 23. UIViewPropertyAnimator

// UIViewPropertyAnimator summary:
// Creates object that can be stopped, continued, started, canceled, paused, reversed
// iOS 10 +
// adding independent blocks with conditions
// delay factor
// simple animations
// keyframe animations
// Spring animations
// Constraints animations
// UIView transition animation
// UIViewController transition animations

// Core animation is more powerful
// Some view animations can be made more easy with UIVIewPropertyAnimator
// We can adjust animation on the fly - we can pause, stop, reverse and alter the speed of animations that are running
// Introduced in iOS 10
// UIView.animate(..) doesn't give us control of animation

func propertyAnimator() {
    let tableView = UITableView()

    let scale = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
    scale.addAnimations {
        tableView.alpha = 1.0
    }

    // We can add as many animations as needed to one property animator
    // We can add some conditions to add some blocks to animator or not add

    // Delay factor is not absolute value as in UIView.animate case
    // it is factor between 0.0 to 1.0 of the remaining duration
    // delayFactor(0.33) * remainingDuration(=duration 0.33) = delay of 0.11
    scale.addAnimations({
        tableView.transform = .identity
    }, delayFactor: 0.33)

    // Adding completion
    // we can add several completions
    // they will be executed one after another in order we add them to animator
    scale.addCompletion { _ in
        print("ready")
    }

    scale.startAnimation()
    scale.startAnimation(afterDelay: 0.3)
}

// It can be enum or struct for this puprose
class AnimatorFactory {
    static func scaleUp(view: UIView) -> UIViewPropertyAnimator {
        let scale = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
        scale.addAnimations {
            view.alpha = 1.0
        }
        scale.addAnimations({
            view.transform = CGAffineTransform.identity
        }, delayFactor: 0.33)
        scale.addCompletion { _ in
            print("ready")
        }
        return scale
    }

    // MARK: - Keyframe animation with UIViewPropertyAnimator

    @discardableResult
    static func jiggle(view: UIView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.33, delay: 0, animations: {
            UIView.animateKeyframes(withDuration: 1, delay: 0,
                                    animations: {
                                        UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                           relativeDuration: 0.25) {
                                            view.transform = CGAffineTransform(rotationAngle: -.pi / 8)
                                        }
                                        UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                           relativeDuration: 0.75) {
                                            view.transform = CGAffineTransform(rotationAngle: +.pi / 8)
                                        }
                                        UIView.addKeyframe(withRelativeStartTime: 0.75,
                                                           relativeDuration: 1.0) {
                                            view.transform = CGAffineTransform.identity
                                        }
                                    },
                                    completion: nil)

        }, completion: { _ in
            view.transform = .identity
        })
    }

    // MARK: - Constraitns with UIViewPropertyAnimator

    @discardableResult
    static func animateConstraint(view: UIView, constraint:
        NSLayoutConstraint, by: CGFloat) -> UIViewPropertyAnimator {
        let spring = UISpringTimingParameters(dampingRatio: 0.2)
        let animator = UIViewPropertyAnimator(
            duration: 2.0,
            timingParameters: spring
        )
        animator.addAnimations {
            constraint.constant += by
            view.layoutIfNeeded()
        }
        return animator
    }
}

// When we need simple animation that need to be fired and we forget about it - use UIView.animate(...)
// When animation is more difficult and we have to keep referce on it - we should use UIViewPropertyAnimator

// runningPropertyAnimator creates and runs animation right away
func toggleBlur(_ blurred: Bool) {
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
        testView.alpha = blurred ? 1.0 : 0
    }, completion: nil)
}

// There is no direct API for repeating animation
// So workaround is to observe running option and once the animation completes, reset animators progress to 0% and start animation from the start

// isRunning - allows to check if animation is already running and if we have to ignore user interaction
// Custom bezier curves - 308 page
// https://cubic-bezier.com/

// MARK: - Custom timing with UIViewPropertyAnimator

func testBezierPropertyAnimator() {
    UIViewPropertyAnimator(
        duration: 0.55,
        controlPoint1: CGPoint(x: 0.57, y: -0.4),
        controlPoint2: CGPoint(x: 0.96, y: 0.87)
    ) {
        testView.alpha = 1.0
    }
}

// MARK: - Spring animations with UIViewPropertyAnimator

func testSpingPropertyAnimator() {
    UIViewPropertyAnimator(duration: 0.4, dampingRatio: 2.0) {
        // Some animation ????
    }

    let spring = UISpringTimingParameters(
        dampingRatio: 0.5,
        initialVelocity: CGVector(dx: 1.0, dy: 0.2)
    )

    let animator = UIViewPropertyAnimator(duration: 1.0, timingParameters: spring)

    let spring2 = UISpringTimingParameters(
        mass: 10.0,
        stiffness: 5.0,
        damping: 30,
        initialVelocity: CGVector(dx: 1.0, dy: 0.2)
    )
    let animator2 = UIViewPropertyAnimator(duration: 1.0, timingParameters: spring2)
}

// MARK: - Cheat code for tableView update with animation

func tableViewUpdateAnimation() {
    let widgetHeight: NSLayoutConstraint = NSLayoutConstraint(item: testView, attribute: .bottom, relatedBy: .equal, toItem: testView, attribute: .bottom, multiplier: 1.0, constant: 1.0)
    let showsMore = true
    let tableView = UITableView()
    let animations = {
        widgetHeight.constant = showsMore ? 230 : 130
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.layoutIfNeeded()
    }
}

// You can create UIView transition animation and pass it to animator

// To change animation when it is already running we can:
// 1. Check if isRunning is true
// 2. Pause animator
// 3. add new animation block
// 4. Continue animation

// MARK: - 24. UIVIewPropertyAnimator interactive animations

// We can control animation by pausing, continuing
// Also we can control animation by setting its progress by hands

// isRunning - true / false - read-only
// isReversed - true / false - default is false, you can set to true and it will return to initial state
// state - .inactive / .active / .stopped - read-only

// state becomes active after startAnimation(), pauseAnimation(), set fractionComplete
// stopAnimation() finishAnimation()
// PauseOnCompletion - bool after completion - animation not stopped, but paused

// someView.snapshotView(afterScreenUpdates: false)

func updatePreview(percent: CGFloat) {
    let previewAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) {
        // some animation
    }
    previewAnimator.fractionComplete =
        max(0.01, min(0.99, percent))
}

// MARK: UIViewPropertyAnimator View Controller Transitions

class PresentTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var auxAnimations: (() -> Void)?
    var auxAnimationsCancel: (() -> Void)?

    func transitionDuration(using transitionContext:
        UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}

    func transitionAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let duration = transitionDuration(using: transitionContext)
        let container = transitionContext.containerView
        let to = transitionContext.view(forKey: .to)!
        container.addSubview(to)
        to.transform = CGAffineTransform(scaleX: 1.33, y: 1.33)
            .concatenating(CGAffineTransform(translationX: 0.0, y: 200))
        to.alpha = 0

        let animator = UIViewPropertyAnimator(duration: duration,
                                              curve: .easeOut)
        animator.addAnimations({
            to.transform = CGAffineTransform(translationX: 0.0, y: 100)
        }, delayFactor: 0.15)
        animator.addAnimations({
            to.alpha = 1.0
        }, delayFactor: 0.5)

        if let auxAnimations = auxAnimations {
            animator.addAnimations(auxAnimations)
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
        }

        return animator
    }
}

// MARK: UIViewPropertyAnimator View Controller Transitions (Interactive) (NOT COVERED)

// UIPercentDrivenInteractiveTransition
// Animation of transition
// Described on 350 page
// Interactive showing of screen - can cancel or finish depending on progress made

// 25. 3d animations

func menuTransform(percent: CGFloat) -> CATransform3D {
    testView.layer.anchorPoint = .zero // 0 to 1
    testView.layer.rasterizationScale = UIScreen.main.scale
    testView.layer.shouldRasterize = false

    var identity = CATransform3DIdentity
    identity.m34 = -1.0 / 1000

    let remainingPercent = 1.0 - percent
    let angle = remainingPercent * .pi * -0.5

    let rotationTransform = CATransform3DRotate(
        identity, angle, 0.0, 1.0, 0.0
    )
    let translationTransform = CATransform3DMakeTranslation(
        10 * percent, 0, 0
    )
    return CATransform3DConcat(
        rotationTransform, translationTransform
    )
}
