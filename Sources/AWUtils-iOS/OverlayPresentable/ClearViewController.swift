//
//  ClearViewController.swift
//  WatchApp
//
//  Created by Adam Wienconek on 20/09/2021.
//  Copyright © 2021 Adam Wienconek. All rights reserved.
//

import UIKit

final class ClearViewController: UIViewController {
    // In the case of view controller-based status bar style, make sure we use the same style for our view controller.

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *),
           let barStyle = UIWindowScene.focused?.statusBarManager?.statusBarStyle {
            return barStyle
        }
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        if #available(iOS 13.0, *),
           let isHidden = UIWindowScene.focused?.statusBarManager?.isStatusBarHidden {
            return isHidden
        }
        return false
    }
    
}

extension ClearViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
}
