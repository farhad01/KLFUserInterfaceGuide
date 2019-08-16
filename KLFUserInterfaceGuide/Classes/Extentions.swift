//
//  Extentions.swift
//  KLFUserInterfaceGuide
//
//  Created by farhad jebelli on 8/15/19.
//

import UIKit

extension UIEdgeInsets {
    init(margin: CGFloat) {
        self = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}

extension CGRect {
    init(center: CGPoint, size: CGSize) {
        self = CGRect(origin: center - size.toPoint() / 2, size: size)
    }
    var center: CGPoint {
        return origin + size.toPoint() / 2
    }
    
    var area: CGFloat {
        return size.area
    }
}

extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static prefix func -(hs: CGPoint) -> CGPoint {
        return .zero - hs
    }
    
    static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

extension CGSize {
    var area: CGFloat {
        return width * height
    }
    static func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }
    
    func toPoint() -> CGPoint {
        return CGPoint(x: width, y: height)
    }
    
}

extension UILabel {
    
    func height(containerWidth: CGFloat) -> CGFloat {
        return self.textRect(forBounds: CGRect(x: 0, y: 0, width: containerWidth, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: Int.max).height
    }
    
    func width(containerHeight: CGFloat) -> CGFloat {
        return self.textRect(forBounds: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: containerHeight), limitedToNumberOfLines: Int.max).width
    }
    
}
