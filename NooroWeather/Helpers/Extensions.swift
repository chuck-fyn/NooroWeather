//
// Extensions.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import SwiftUI

extension Font {
    static func poppinsRegular(size: CGFloat) -> Font {
        .custom("Poppins-Regular", size: size)
    }
    static func poppinsMedium(size: CGFloat) -> Font {
        .custom("Poppins-Medium", size: size)
    }
    static func poppinsSemiBold(size: CGFloat) -> Font {
        .custom("Poppins-SemiBold", size: size)
    }
    static func poppinsBold(size: CGFloat) -> Font {
        .custom("Poppins-Bold", size: size)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
