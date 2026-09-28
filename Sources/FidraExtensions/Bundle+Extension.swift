import Combine
import SwiftUI

// Đọc các biến môi trường từ xcconfig
extension Bundle {
    public static var appleAppID: String {
        return Bundle.main.object(forInfoDictionaryKey: "APPLE_APP_ID") as? String ?? ""
    }
    
    public static var isDebug: Bool {
        let debugString = Bundle.main.object(forInfoDictionaryKey: "IS_DEBUG") as? String ?? "false"
        return debugString.lowercased() == "true"
    }
    
    public static var appsFlyerDevKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "APPSFLYER_DEV_KEY") as? String ?? ""
    }
}
