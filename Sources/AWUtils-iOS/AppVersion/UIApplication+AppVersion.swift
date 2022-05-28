//
//  File.swift
//  
//
//  Created by Adam Wienconek on 28/05/2022.
//

import Foundation
import UIKit

public extension UIApplication {
    
    var version: AppVersion {
        let bundle: Bundle = .main
        guard let rawVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
              let rawBuild = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String,
              let build = Int(rawBuild) else {
            return .init(project: .unknown, build: NSNotFound)
        }
        let project = Project(rawVersion)
        return .init(project: project, build: build)
    }
    
    private(set) static var lastInstalledVersion: AppVersion? {
        get {
            guard let data = UserDefaults.standard.data(forKey: "LAST_INSTALLED_APP_VERSION"),
                  let decoded = try? JSONDecoder().decode(Self.self, from: data) else {
                return nil
            }
            return decoded
        } set {
            guard let newValue = newValue,
                  let data = try? JSONEncoder().encode(newValue) else {
                UserDefaults.standard.removeObject(forKey: "LAST_INSTALLED_APP_VERSION")
                return
            }
            UserDefaults.standard.set(data, forKey: "LAST_INSTALLED_APP_VERSION")
        }
    }
    
    static func updateLastInstalledVersion() {
        lastInstalledVersion = .init(bundle: .main)
    }
    
}
