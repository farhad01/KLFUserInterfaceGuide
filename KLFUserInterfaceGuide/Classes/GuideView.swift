//
//  GuideView.swift
//  KLFUserInterfaceGuide
//
//  Created by farhad jebelli on 8/15/19.
//

import UIKit

class GuideView: UIView, GuideViewProtocol {
    var title_: NSAttributedString!
    
    var guideRect: CGRect!
    var config: KLFUserInterfaceGuide.Config!
    var shouldShowOnTop = true
    var message: NSAttributedString! {
        didSet {
            messageView.attributedText = message
        }
    }
    
    let outerPathLayer = CAShapeLayer()
    let innerPathLayer = CAShapeLayer()
    let messageBoundsLayer = CAShapeLayer()
    let mirrorMessageBoundsLayer = CAShapeLayer()
    
    
    
    let messageView = UILabel()
    
    var point1: CGPoint {
        let diff = CGPoint(x: 0, y: guideRect.height / 2 + config.rectMargin)
        return guideRect.center + (shouldShowOnTop ? -diff : diff)
    }
    var point2: CGPoint {
        let diff = CGPoint(x: 0, y: 30)
        return point1 + (shouldShowOnTop ? -diff : diff)
    }
    var point3: CGPoint { return
        CGPoint(x: bounds.width / 2, y: point2.y)
    }
    var point4: CGPoint {
        let diff = CGPoint(x: 0, y: 30)
        return point3 + (shouldShowOnTop ? -diff : diff)
    }
    
    var messageFrame: CGRect {
        let messageWidth = bounds.width - 50
        let messageHeight = messageView.height(containerWidth: messageWidth)
        
        return CGRect(x: 25, y: point4.y + (shouldShowOnTop ? -10 - messageHeight : 10), width: messageWidth, height: messageHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    private func setupView() {
        layer.addSublayer(messageBoundsLayer)
        layer.addSublayer(mirrorMessageBoundsLayer)
        layer.addSublayer(outerPathLayer)
        layer.addSublayer(innerPathLayer)
        
        addSubview(messageView)
        
        messageView.backgroundColor = .clear
        messageView.textColor = .black
        messageView.numberOfLines = 0
        
        
    }
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard self.guideRect != nil, self.config != nil else {
            return
        }
        messageView.textColor = config.bubbleTextColor
        messageView.font = config.font
        messageView.textAlignment = config.textAlignment
        
        outerPathLayer.frame = layer.bounds
        innerPathLayer.frame = layer.bounds
        
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        setupRect()
        setupPathLayer()
        setupMessage()
        CATransaction.commit()
        setupAnimations()
        
    }
    
    private func setupRect() {
        let shapeLayer = layer as! CAShapeLayer
        
        let outerBezierPath = UIBezierPath(rect: bounds)
        let innerBezierPath = UIBezierPath(roundedRect: guideRect.inset(by: UIEdgeInsets(margin: -config.rectMargin)), cornerRadius: config.rectRadius)
        
        outerBezierPath.append(innerBezierPath)
        
        shapeLayer.path = outerBezierPath.cgPath
        shapeLayer.fillRule = .evenOdd
        
        shapeLayer.fillColor = config.background.withAlphaComponent(config.alpha).cgColor
        
        shapeLayer.shadowColor = config.background.cgColor
        shapeLayer.shadowRadius = config.rectMargin
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowOpacity = 1
    }
    
    private func setupPathLayer() {
        
        let firstDot = UIBezierPath(ovalIn: CGRect(center: point1, size: CGSize(width: 3, height: 2)))
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        let secoundDot = UIBezierPath(ovalIn: CGRect(center: point4, size: CGSize(width: 3, height: 2)))
        firstDot.append(path)
        firstDot.append(secoundDot)
        
        innerPathLayer.path = firstDot.cgPath
        innerPathLayer.strokeColor = config.bubbleBackgroundColor.cgColor
        innerPathLayer.lineWidth = 2
        innerPathLayer.fillColor = UIColor.clear.cgColor
        
        outerPathLayer.path = firstDot.cgPath
        outerPathLayer.strokeColor = config.bubbleBorderColor.cgColor
        outerPathLayer.lineWidth = 8
        outerPathLayer.fillColor = UIColor.clear.cgColor
        
        
        
    }
    
    private func setupMessage() {
        
        messageView.frame = messageFrame
        
        let messageViewBorderFrame = messageView.frame.inset(by: UIEdgeInsets(margin: -10))
        mirrorMessageBoundsLayer.frame = messageViewBorderFrame
        messageBoundsLayer.frame = messageViewBorderFrame
        
        let messageFrame = halfRectBezierPath(rect: messageBoundsLayer.bounds, cornrtRadius: 8)
        
        messageBoundsLayer.path = messageFrame.cgPath
        messageBoundsLayer.strokeColor = config.bubbleBorderColor.cgColor
        messageBoundsLayer.lineWidth = 4
        messageBoundsLayer.fillColor = config.bubbleBackgroundColor.cgColor
        messageBoundsLayer.strokeStart = 0
        messageBoundsLayer.strokeEnd = 0
        messageBoundsLayer.setAffineTransform(CGAffineTransform(scaleX: 1, y: shouldShowOnTop ? -1 : 1))
        
        mirrorMessageBoundsLayer.path = messageFrame.cgPath
        mirrorMessageBoundsLayer.strokeColor = config.bubbleBorderColor.cgColor
        mirrorMessageBoundsLayer.lineWidth = 4
        mirrorMessageBoundsLayer.fillColor = config.bubbleBackgroundColor.cgColor
        mirrorMessageBoundsLayer.strokeStart = 0
        mirrorMessageBoundsLayer.strokeEnd = 0
        
        mirrorMessageBoundsLayer.setAffineTransform(CGAffineTransform(scaleX: -1, y: shouldShowOnTop ? -1 : 1))
        
        messageView.alpha = 0
        
        
    }
    private func setupAnimations() {
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.messageView.alpha = 1
        }, completion: nil)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 0.5
            animation.fillMode = CAMediaTimingFillMode.forwards;
            animation.isRemovedOnCompletion = false;
            
            self.mirrorMessageBoundsLayer.add(animation, forKey: "")
            self.messageBoundsLayer.add(animation, forKey: "")
            
            
            CATransaction.setAnimationDuration(0.5)
            CATransaction.commit()
            
        })
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        innerPathLayer.add(animation, forKey: "")
        outerPathLayer.add(animation, forKey: "")
        CATransaction.setAnimationDuration(0.5)
        CATransaction.commit()
        
    }
    
    private func halfRectBezierPath(rect: CGRect, cornrtRadius: CGFloat) -> UIBezierPath {
        let point1 = rect.origin + CGPoint(x: rect.width/2 - 1, y: 0)
        
        let point2 = point1 +  CGPoint(x: rect.width/2 - cornrtRadius, y: 0)
        let point3 = point2 + CGPoint(x: cornrtRadius, y: 0)
        let point4 = point3 + CGPoint(x: 0, y: cornrtRadius)
        
        let point5 = point4 + CGPoint(x: 0, y: rect.height - 2*cornrtRadius)
        let point6 = point5 + CGPoint(x: 0, y: cornrtRadius)
        let point7 = point6 - CGPoint(x: cornrtRadius, y: 0)
        
        let point8 = CGPoint(x: point1.x, y: point7.y)
        
        let bezier = UIBezierPath()
        bezier.move(to: point1)
        bezier.addLine(to: point2)
        
        bezier.addQuadCurve(to: point4, controlPoint: point3)
        
        bezier.addLine(to: point5)
        
        bezier.addQuadCurve(to: point7, controlPoint: point6)
        
        bezier.addLine(to: point8)
        
        return bezier
        
        
    }
    
}
