//
//  GuideViewProtocol.swift
//  KLFUserInterfaceGuide
//
//  Created by Farhad on 3/2/21.
//

import Foundation

protocol GuideViewProtocol: class {
    var guideRect: CGRect! {get set}
    var config: KLFUserInterfaceGuide.Config! {get set}
    var shouldShowOnTop: Bool {get set}
    var message: NSAttributedString! {get set}
    var title_: NSAttributedString! {get set}
}
