
import Foundation

public struct AppVersion: Codable {
    
    public let project: Project
    public let build: Int
    
    init(bundle: Bundle) {
        guard let rawVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
              let rawBuild = bundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String,
              let build = Int(rawBuild) else {
            return .init(project: .unknown, build: NSNotFound)
        }
        self.project = Project(rawVersion)
        self.build = build
    }
    
}

extension AppVersion: CustomStringConvertible {
    
    public var description: String {
        var project = project.description
        #if DEBUG
            project += ", build \(build)"
        #endif
        return project
    }
    
}
