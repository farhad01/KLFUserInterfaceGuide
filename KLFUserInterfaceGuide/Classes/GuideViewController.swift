//
//  GuideViewController.swift
//  KLFUserInterfaceGuide
//
//  Created by farhad jebelli on 8/15/19.
//

import UIKit

class GuideViewController: UIViewController {
    var destView: UIView!
    var message: NSAttributedString!
    
    var dismissWhenTappedOutside: Bool = false
    
    var decision: GuideDecision?
    var dismissByTapOutsideCompletion: GuideCompletion!
    var completion: GuideCompletion?
    
    var destRect: CGRect {
        return view.convert(destView.frame, from: destView.superview)
    }
    
    override func loadView() {
        super.loadView()
        view = GuideView()
    }
    
    var guideView: GuideView {
        return view as! GuideView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(gesture)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guideView.guideRect = destRect
        guideView.shouldShowOnTop = !isLocatedOnTop(rect: destRect)
        guideView.config = KLFUserInterfaceGuide.config
        guideView.message = message
    }
    
    private func isLocatedOnTop(rect: CGRect) -> Bool {
        let top = CGRect(origin: view.bounds.origin, size: CGSize(width: view.bounds.width, height: view.bounds.height/2))
        let bottom = CGRect(origin: view.bounds.origin + CGPoint(x: 0, y: top.height), size: top.size)
        
        let topIntersection = top.intersection(rect)
        let bottomIntersection = bottom.intersection(rect)
        
        return topIntersection.area > bottomIntersection.area
    }
    
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        if destRect.contains(sender.location(in: view)) {
            let locationInDest = view.convert(sender.location(in: view), to: destView)
            if decision?(locationInDest) ?? true {
                dismiss(animated: true, completion: completion)
            }
        } else if dismissWhenTappedOutside {
            dismiss(animated: true, completion: dismissByTapOutsideCompletion)
        }
        
    }
}

