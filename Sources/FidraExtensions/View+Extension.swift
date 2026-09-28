//
//  View+Extension.swift
//  FidraCore
//
//  Created by HoaTD on 5/3/25.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

// MARK: - View Loading
extension View {
    /// Executes an action only once when the view appears
    public func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

// MARK: - View Styling
extension View {
    /// Adds corner radius with border
    public func cornerRadiusWithBorder(
        radius: CGFloat,
        borderLineWidth: CGFloat = 1,
        borderColor: Color = .gray,
        antialiased: Bool = true
    ) -> some View {
        modifier(ModifierCornerRadiusWithBorder(
            radius: radius,
            borderLineWidth: borderLineWidth,
            borderColor: borderColor,
            antialiased: antialiased
        ))
    }
    
    /// Adds corner radius to specific corners
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension View {
    public func roundedCornerWithBorder(lineWidth: CGFloat, borderColor: Color, radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
            .overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(borderColor, lineWidth: lineWidth))
    }
}

fileprivate struct ModifierCornerRadiusWithBorder: ViewModifier {
    var radius: CGFloat
    var borderLineWidth: CGFloat = 1
    var borderColor: Color = .gray
    var antialiased: Bool = true
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius, antialiased: self.antialiased)
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .inset(by: self.borderLineWidth)
                    .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
            )
    }
}


extension View {
    /// Hides or shows the view based on a boolean value
    @ViewBuilder public func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

// MARK: - View Keyboard
extension View {
    /// Dismisses keyboard when tapped outside
    public func dismissKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                         to: nil, from: nil, for: nil)
        }
    }
}
