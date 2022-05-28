import Foundation

public enum AppConfiguration: String {
    
    case debug, test, release
    
    public static var current: Self {
        if isDebug {
            return .debug
        }
        else if isTestFlight {
            return .test
        }
        return .release
    }
}

private extension AppConfiguration {
    
    static var isTestFlight: Bool {
        Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    }
    
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
}

extension AppConfiguration: CustomStringConvertible {
    
    public var description: String { rawValue.capitalized }
    
}
