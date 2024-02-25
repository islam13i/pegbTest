//
//  Configure.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

struct Configure {

    enum Font: String {
        case bold = "Montserrat-Bold"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"

        func font(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }

    enum IconImage {
        static let placeholder = "icon"
        static let newsIcon = "globe"
        static let favoritesIcon = "bookmark"
        static let favoritesFillIcon = "bookmark.fill"
        static let calendarIcon = "calendar"
        static let authorIcon = "newspaper"
        static let back = "xmark"
        static let logout = "logout"
    }

    struct Color {
        static var tabbarTintColor: UIColor {#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)}
        static var clearColor: UIColor {#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)}
        static var viewBackground: UIColor {#colorLiteral(red: 0.9411759377, green: 0.9411769509, blue: 0.9626820683, alpha: 1)}
        static var titleColor: UIColor {#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
        static var cellTitleColor: UIColor {#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)}
        static var descriptionColor: UIColor {#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)}
        static var buttonTextColor: UIColor {#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)}
        static var buttonBackgroundColor: UIColor {#colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)}
        static var cellBackgroundColor: UIColor {#colorLiteral(red: 0.8430537581, green: 0.843195796, blue: 0.8430350423, alpha: 1)}
        static var redColor: UIColor {UIColor.red}
        static var blackColor: UIColor {UIColor.black}
    }
}
