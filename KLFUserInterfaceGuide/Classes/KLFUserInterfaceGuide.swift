

import UIKit

public typealias GuideDecision = (CGPoint) -> Bool
public typealias GuideCompletion = () -> Void

public class KLFUserInterfaceGuide {
    public static var config: Config = Config()
    
    fileprivate static var queue: [UserGuide] = []
    
    public struct Config {
        public var alpha: CGFloat = 0.8
        public var background = UIColor.googleBlue
        public var rectMargin: CGFloat = 10
        public var rectRadius: CGFloat = 10
        public var font = UIFont.systemFont(ofSize: 14)
        public var textAlignment: NSTextAlignment = .natural
        init() {
            
        }
        
    }
    
    public static func guideShouldShow(tag: String) -> Bool {
        let tag = userGuideTag(tag: tag)
        return !UserDefaults.standard.bool(forKey: tag)
    }
    
    static func userGuideTag(tag: String) -> String {
        return "KLFUserInterfaceGuide-\(tag)"
    }

    fileprivate static func presentUserInterfaceGuide(userGuide: UserGuide) {
        let guideViewController = GuideViewController()
        guideViewController.destView = userGuide.view
        guideViewController.message = userGuide.message
        guideViewController.dismissWhenTappedOutside = userGuide.dismissWhenTapedOutside
        guideViewController.decision = userGuide.decision
        guideViewController.dismissByTapOutsideCompletion = userGuide.dismissByTapOutsideCompletion
        guideViewController.completion = userGuide.completion
        guideViewController.modalPresentationStyle = .overCurrentContext
        guideViewController.modalTransitionStyle = .crossDissolve
        userGuide.controller.present(guideViewController, animated: true, completion: nil)
    }
    
    fileprivate static func handleNextInQueue() {
        if let userGuide = queue.first {
            presentUserInterfaceGuide(userGuide: userGuide)
        }
    }
    
}

private struct UserGuide {
    let view: UIView, message: NSAttributedString, tag: String?, dismissWhenTapedOutside: Bool,decision: GuideDecision?, dismissByTapOutsideCompletion: GuideCompletion, completion: GuideCompletion?, controller: UIViewController
}

public extension UIViewController {

    func presentUserInterfaceGuide(view: UIView, message: NSAttributedString, tag: String? = nil, dismissWhenTapedOutside: Bool = false,decision: GuideDecision? = nil, completion: GuideCompletion? = nil) {
        if let tag = tag {
            if KLFUserInterfaceGuide.guideShouldShow(tag: tag) {
                UserDefaults.standard.set(true, forKey: KLFUserInterfaceGuide.userGuideTag(tag: tag))
            } else {
                return
            }
        }
        let userGuide = UserGuide(view: view, message: message, tag: tag, dismissWhenTapedOutside: dismissWhenTapedOutside, decision: decision, dismissByTapOutsideCompletion: {
            KLFUserInterfaceGuide.queue.removeFirst()
            KLFUserInterfaceGuide.handleNextInQueue()
        }, completion: {
            completion?()
            KLFUserInterfaceGuide.queue.removeFirst()
            KLFUserInterfaceGuide.handleNextInQueue()
        }, controller: self)
        
        if KLFUserInterfaceGuide.queue.isEmpty {
            KLFUserInterfaceGuide.queue.append(userGuide)
            KLFUserInterfaceGuide.handleNextInQueue()
        } else {
            KLFUserInterfaceGuide.queue.append(userGuide)
        }

    }
    
    func presentUserInterfaceGuide(view: UIView, message: String, tag: String? = nil, dismissWhenTapedOutside: Bool = false,decision: GuideDecision? = nil, completion: GuideCompletion? = nil) {
        presentUserInterfaceGuide(view: view, message: NSAttributedString(string: message), tag: tag, dismissWhenTapedOutside: dismissWhenTapedOutside, decision: decision, completion: completion)
    }
}
