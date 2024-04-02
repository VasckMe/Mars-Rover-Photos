//
//  UIViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit

extension UIViewController {
    func displayController(_ controller: UIViewController, frame: CGRect) {
        addChild(controller)
        controller.view.frame = frame
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.beginAppearanceTransition(true, animated: true)
        view.addSubview(controller.view)
        controller.endAppearanceTransition()
        controller.didMove(toParent: self)
    }

    func hideController(_ controller: UIViewController?) {
        controller?.willMove(toParent: nil)
        controller?.beginAppearanceTransition(false, animated: false)
        controller?.view.removeFromSuperview()
        controller?.endAppearanceTransition()
        controller?.removeFromParent()
    }
}
