//
//  String+Extension.swift
//  FidraCore
//
//  Created by HoaTD on 3/3/25.
//

import Foundation

extension String {
    public func titleCased() -> String {
        return self.lowercased()
            .split(separator: " ")
            .map { $0.prefix(1).uppercased() + $0.dropFirst() }
            .joined(separator: " ")
    }

    public func isRTL() -> Bool {
        let rtlLanguages = ["ar", "arc", "dv", "fa", "ha", "he", "khw", "ks", "ku", "ps", "ur", "yi"]
        return rtlLanguages.contains(self)
    }
}
