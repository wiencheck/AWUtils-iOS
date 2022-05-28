//
//  OverlayPresenter.swift
//  WatchApp
//
//  Created by Adam Wienconek on 27/09/2021.
//  Copyright © 2021 Adam Wienconek. All rights reserved.
//

import UIKit

final class OverlayPresenter {
    
    @available(*, unavailable)
    init() {}

    private static var windows: [UIWindow] = []

    class var overlayWindow: UIWindow? { windows.last }

    @discardableResult
    class func showOverlay(inWindow configuration: ((UIWindow) -> Void)? = nil) -> UIWindow {
        
        let window = makeOverlayWindow()
        configuration?(window)
        windows.append(window)
        window.makeKeyAndVisible()

        return window
    }

    class func dismissOverlayIfNeeded() {
        overlayWindow?.rootViewController?.dismiss(animated: true)
    }

    class func dismissOverlay(withWindow window: UIWindow) {
        guard let overlayWindowIndex = windows.firstIndex(of: window) else {
            return
        }

        if let controller = windows[overlayWindowIndex].rootViewController {
            controller.dismiss(animated: true) {
                windows.remove(at: overlayWindowIndex)
            }
        } else {
            windows.remove(at: overlayWindowIndex)
        }
    }

    private class func makeOverlayWindow() -> UIWindow {
        let window: UIWindow
        if #available(iOS 13.0, *),
           let scene = UIWindowScene.focused {
            window = UIWindow(windowScene: scene)
            window.tintColor = scene.windows.first?.tintColor
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window.tintColor = UIApplication.shared.keyWindow?.tintColor
        }
        window.windowLevel = .alert
        window.rootViewController = ClearViewController()

        return window
    }
}
