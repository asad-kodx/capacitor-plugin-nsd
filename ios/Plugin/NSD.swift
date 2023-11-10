import Foundation

@objc public class NSD: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
