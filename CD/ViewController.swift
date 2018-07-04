//
//  ViewController.swift
//  CD
//
//  Created by Prime on 7/3/18.
//  Copyright © 2018 prime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var playing = false

    var animator = UIDynamicAnimator(referenceView: UIView())
    var dynamicItemBehavior = UIDynamicItemBehavior()

    let length: CGFloat = 480
    let cd = CD(image: UIImage(named: "LP.jpg"))
    let needle = UIImageView(image: UIImage(named: "needle.png"))
    var startPanAngle: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        cd.frame = CGRect(origin: .zero, size: CGSize(width: length, height: length))
        cd.center = view.center
        view.addSubview(cd)

        setUpDynamics()

        needle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(_:))))
        needle.isUserInteractionEnabled = true
        needle.layer.anchorPoint = CGPoint(x: 0.5, y: 75.0 / 600)
        needle.frame = CGRect(
            x: view.frame.size.width - 100 - 60,
            y: 20 + 60,
            width: 100,
            height: 600
        )
        view.addSubview(needle)
    }

    func setUpDynamics() {
        animator = UIDynamicAnimator(referenceView: view)
        dynamicItemBehavior.addItem(cd)
        animator.addBehavior(dynamicItemBehavior)
    }

    @objc func pan(_ pan: UIPanGestureRecognizer) {
        let transform = needle.transform
        UIView.setAnimationsEnabled(false)
        needle.transform = CGAffineTransform.identity

        let point = pan.location(in: pan.view)
        var panAngle = atan((50 - point.x) / (point.y - 75))
        if pan.state == .began {
            startPanAngle = playing ? panAngle - 0.3 : panAngle
        }
        panAngle -= startPanAngle

        UIView.setAnimationsEnabled(true)
        needle.transform = transform

        if pan.state == .cancelled || pan.state == .ended {
            if panAngle >= 0.3 {
                play()
            } else {
                pause()
            }
        } else {

            needle.transform = CGAffineTransform(rotationAngle: panAngle)
        }
    }

    func play() {
        playing = true

        UIView.animate(withDuration: 0.3, animations: {
            self.needle.transform = CGAffineTransform(rotationAngle: 0.3)
        })

        dynamicItemBehavior.angularResistance = 0
        dynamicItemBehavior.addAngularVelocity(-dynamicItemBehavior.angularVelocity(for: cd), for: cd)
        dynamicItemBehavior.addAngularVelocity(CGFloat.pi, for: cd)
    }

    func pause() {
        playing = false

        UIView.animate(withDuration: 0.3, animations: {
            self.needle.transform = CGAffineTransform.identity
        }) { (finished) in
            self.dynamicItemBehavior.angularResistance = 3
        }
    }
}
