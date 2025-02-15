//
//  Color+.swift
//  HubSwiftUI
//
//  Created by ncn on 2/12/25.
//


import UIKit
import SwiftUI

public extension UIColor {
  convenience init(hex: String) {
    self.init(hexCode: hex)
  }

  convenience init(hexCode: String, alpha: CGFloat = 1.0) {
    var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      .uppercased()

    if hexFormatted.hasPrefix("#") {
      hexFormatted = String(hexFormatted.dropFirst())
    }

    assert(hexFormatted.count == 6, "Invalid hex code used.")

    var rgbValue: UInt64 = 0
    Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: alpha)
  }
}

public extension UIColor {
  // hub color palette
  static let black = UIColor(hex: "#000000")
  static let white = UIColor(hex: "#FFFFFF")
  static let softBlue = UIColor(hex: "#00B9F2")
  static let lightBlue = UIColor(hex: "#D6F5FF")
  static let deepBlue = UIColor(hex: "#0082CA")

  //gray
  static let lightGray = UIColor(hex: "#D3D3D3")
  static let mediumGray = UIColor(hex: "#929497")
  static let darkGray = UIColor(hex: "#1B1B1B")

  static let grayFb = UIColor(hex: "#FAFAFB")
  static let grayD1 = UIColor(hex: "#D1D1D1")
  static let grayEC = UIColor(hex: "#ECECEC")
  static let gray24 = UIColor(hex: "#242424")  // homeButtonGray
  static let grayF5 = UIColor(hex: "#F5F5F5")
  static let gray58 = UIColor(hex: "#58595B")
  static let gray82 = UIColor(hex: "#828282")
  static let gray1C = UIColor(hex: "#1C1C1C") // popupBg
  static let gray3E = UIColor(hex: "#3E3E3E") // popupLine
  static let grayD9 = UIColor(hex: "#D9D9D9")

  // hub color theme
  static var primary: UIColor = softBlue
  static var secondaryPrimary: UIColor = deepBlue
  static var text: UIColor = darkGray
  static var cellText: UIColor = gray58
  static var tableCellBackground: UIColor = grayFb
  static var secondText: UIColor = mediumGray
  static var divider: UIColor = grayF5
  static var symbol: UIColor = lightGray
  static var error: UIColor = red

  // new
  static let grayF1 = UIColor(hex: "#F1F4F6")
  static let grayF2 = UIColor(hex: "#F2F3F5")
  static let grayD9DD = UIColor(hex: "#D9DDE2")
  static let grayB0 = UIColor(hex: "#B0B8C1")
  static let gray86 = UIColor(hex: "#8695A3")
  static let gray33 = UIColor(hex: "#333D4B")
  static let gray63 = UIColor(hex: "#636A70")
  static let gray74 = UIColor(hex: "#747474")
  static let mainBlack = UIColor(hex: "#000000")
  static let vueroidBlue = UIColor(hex: "#00B9F2")
  static let mainBlue = UIColor(hex: "#477EE3")
  static let blue10 = UIColor(hex: "#F2F7FF")
  static let mainGreen = UIColor(hex: "#00CD60")
  static let green10 = UIColor(hex: "#EEFFF2")
  static let mainRed = UIColor(hex: "#F73631")
  static let red10 = UIColor(hex: "#FFECEE")
  static let purple = UIColor(hex: "#7346F3")

  // new
  static var background: UIColor = grayF1
  static var grayButton: UIColor = grayF2
  static var linePressed: UIColor = grayD9DD
  static var line: UIColor = grayD9DD
  static var icon: UIColor = grayB0
  static var iconDark: UIColor = grayB0
  static var subText: UIColor = gray33
  static var grayText: UIColor = gray63
  static var disable: UIColor = gray74
}

public extension Color {
  // hub color palette
  static let black = Color(UIColor.black)
  static let white = Color(UIColor.white)
  static let softBlue = Color(UIColor.softBlue)
  static let lightBlue = Color(UIColor.lightBlue)
  static let deepBlue = Color(UIColor.deepBlue)

  // gray
  static let lightGray = Color(UIColor.lightGray)
  static let mediumGray = Color(UIColor.mediumGray)
  static let darkGray = Color(UIColor.darkGray)
  static let grayFb = Color(UIColor.grayFb)
  static let grayD1 = Color(UIColor.grayD1)
  static let grayEC = Color(UIColor.grayEC)
  static let gray24 = Color(UIColor.gray24)
  static let grayF5 = Color(UIColor.grayF5)
  static let gray58 = Color(UIColor.gray58)
  static let gray82 = Color(UIColor.gray82)
  static let gray1C = Color(UIColor.gray1C)
  static let gray3E = Color(UIColor.gray3E)
  static let grayD9 = Color(UIColor.grayD9)

  // hub color theme
  static var primary: Color { Color(UIColor.primary) }
  static var secondaryPrimary: Color { Color(UIColor.secondaryPrimary) }
  static var text: Color { Color(UIColor.text) }
  static var cellText: Color { Color(UIColor.cellText) }
  static var tableCellBackground: Color { Color(UIColor.tableCellBackground) }
  static var secondText: Color { Color(UIColor.secondText) }
  static var divider: Color { Color(UIColor.divider) }
  static var symbol: Color { Color(UIColor.symbol) }
  static var error: Color { Color(UIColor.error) }

  // new
  static let grayF1 = Color(UIColor.grayF1)
  static let grayF2 = Color(UIColor.grayF2)
  static let grayD9DD = Color(UIColor.grayD9DD)
  static let grayB0 = Color(UIColor.grayB0)
  static let gray86 = Color(UIColor.gray86)
  static let gray33 = Color(UIColor.gray33)
  static let gray63 = Color(UIColor.gray63)
  static let gray74 = Color(UIColor.gray74)
  static let mainBlack = Color(UIColor.mainBlack)
  static let vueroidBlue = Color(UIColor.vueroidBlue)
  static let mainBlue = Color(UIColor.mainBlue)
  static let blue10 = Color(UIColor.blue10)
  static let mainGreen = Color(UIColor.mainGreen)
  static let green10 = Color(UIColor.green10)
  static let mainRed = Color(UIColor.mainRed)
  static let red10 = Color(UIColor.red10)
  static let purple = Color(UIColor.purple)

  // new theme
  static var background: Color { Color(UIColor.background) }
  static var grayButton: Color { Color(UIColor.grayButton) }
  static var linePressed: Color { Color(UIColor.linePressed) }
  static var line: Color { Color(UIColor.line) }
  static var icon: Color { Color(UIColor.icon) }
  static var iconDark: Color { Color(UIColor.iconDark) }
  static var subText: Color { Color(UIColor.subText) }
  static var grayText: Color { Color(UIColor.grayText) }
  static var disable: Color { Color(UIColor.disable) }
}
