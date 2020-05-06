// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen


import UIKit.UIColor

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
internal extension UIColor {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
internal struct Colors {
  internal let rgbaValue: UInt32
  internal var color: UIColor { return UIColor(named: self) }

  /// #000099
  internal static let primary = UIColor(rgbaValue: 0x000099ff)
}
// swiftlint:enable identifier_name line_length type_body_length

internal extension UIColor {
  convenience init(named color: Colors) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
