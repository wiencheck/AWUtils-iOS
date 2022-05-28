//
//  File.swift
//  
//
//  Created by Adam Wienconek on 28/05/2022.
//

import UIKit

public extension UIWindowScene {
    
    static var focused: UIWindowScene? {
        return UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive && $0 is UIWindowScene } as? UIWindowScene
    }
    
}
