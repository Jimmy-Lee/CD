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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        cd.frame = CGRect(origin: .zero, size: CGSize(width: length, height: length))
        cd.center = view.center
        view.addSubview(cd)

        setUpDynamics()

        let playPauseButton = UIButton(type: .system)
        playPauseButton.backgroundColor = .white
        playPauseButton.addTarget(self, action: #selector(togglePlay), for: .touchUpInside)
        view.addSubview(playPauseButton)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let constraint = playPauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        constraint.constant = -40
        constraint.isActive = true

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

    @objc func togglePlay() {
        playing = !playing

        if playing {
            UIView.animate(withDuration: 0.3, animations: {
                self.needle.transform = CGAffineTransform(rotationAngle: 0.3)
            })

            dynamicItemBehavior.angularResistance = 0
            dynamicItemBehavior.addAngularVelocity(-dynamicItemBehavior.angularVelocity(for: cd), for: cd)
            dynamicItemBehavior.addAngularVelocity(CGFloat.pi, for: cd)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.needle.transform = CGAffineTransform.identity
            }) { (finished) in
                self.dynamicItemBehavior.angularResistance = 3
            }
        }
    }
}
