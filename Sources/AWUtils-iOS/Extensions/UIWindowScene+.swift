//
//  File.swift
//  
//
//  Created by Adam Wienconek on 28/05/2022.
//

import UIKit

@available(iOS 13.0, *)
extension UIWindowScene {
    
    static var focused: UIWindowScene? {
        return UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive && $0 is UIWindowScene } as? UIWindowScene
    }
    
}
