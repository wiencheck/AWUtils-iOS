//
//  PresentableInOverlay.swift
//  Glarm
//
//  Created by Adam Wienconek on 05/01/2022.
//  Copyright © 2022 Adam Wienconek. All rights reserved.
//

import UIKit

public protocol OverlayPresentable: UIViewController {
    var window: UIWindow? { get set }
}

public extension OverlayPresentable {
    
    func cleanupAfterPresentation() {
        if let window = window {
            OverlayPresenter.dismissOverlay(withWindow: window)
        } else {
            OverlayPresenter.dismissOverlayIfNeeded()
        }
    }
    
    /**
     Displays alert in separate window over the app.
     
     - Parameters:
        - animated: Pass true to animate the presentation; otherwise, pass false.
        - sourceView: The view containing the anchor rectangle for the popover. (optional)
        - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
     */
    func show(animated flag: Bool = true, sourceView: UIView? = nil, completion: (() -> Void)? = nil) {
        
        window = OverlayPresenter.showOverlay()
        
        if let sourceView = sourceView {
            modalPresentationStyle = .popover
            
            popoverPresentationController?.delegate = rootViewController
            popoverPresentationController?.sourceView = sourceView
            popoverPresentationController?.sourceRect = sourceView.bounds
            popoverPresentationController?.permittedArrowDirections = .any
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(objc_dismiss))
            rootViewController?.view.addGestureRecognizer(tap)
        }
        
        rootViewController?.present(self, animated: flag, completion: completion)
    }

    /**
     Displays alert in separate window over the app.
     
     - Parameters:
        - animated: Pass true to animate the presentation; otherwise, pass false.
        - barButtonItem: The bar button item on which to anchor the popover (iPad only)
        - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
     */
    func show(animated flag: Bool = true, barButtonItem: UIBarButtonItem?, completion: (() -> Void)? = nil) {
        
        window = OverlayPresenter.showOverlay()

        if let barButtonItem = barButtonItem {
            modalPresentationStyle = .popover
            
            popoverPresentationController?.delegate = rootViewController
            popoverPresentationController?.barButtonItem = barButtonItem
            popoverPresentationController?.permittedArrowDirections = .any
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(objc_dismiss))
            rootViewController?.view.addGestureRecognizer(tap)
        }
        
        rootViewController?.present(self, animated: flag, completion: completion)
    }
    
    private var rootViewController: ClearViewController? {
        window?.rootViewController as? ClearViewController
    }
}
