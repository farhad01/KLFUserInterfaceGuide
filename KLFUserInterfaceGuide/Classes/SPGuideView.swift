//
//  SPGuideView.swift
//  KLFUserInterfaceGuide
//
//  Created by Farhad on 3/2/21.
//

import UIKit

class SPGuideView: UIView, GuideViewProtocol {
    var title_: NSAttributedString!
    
    var guideRect: CGRect!
    
    var config: KLFUserInterfaceGuide.Config!
    
    var shouldShowOnTop: Bool = true
    
    var message: NSAttributedString!
    
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let stack = UIStackView()
    let backgroundView = UIView()
    
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        stack.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(stack)
        
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(messageLabel)
        
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        topConstraint = backgroundView.topAnchor.constraint(equalTo: topAnchor)
        bottomConstraint = backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activeAll {
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            
            stack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor)
            stack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
            stack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16)
            stack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16)
        }
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRect()
        topConstraint.constant = guideRect.maxY + 16
        bottomConstraint.constant = -(frame.height - guideRect.minY + 16)
        topConstraint.isActive = !shouldShowOnTop
        bottomConstraint.isActive = shouldShowOnTop
        
        backgroundView.backgroundColor = config.bubbleBackgroundColor
        backgroundView.layer.borderColor = config.bubbleBorderColor.cgColor
        
        messageLabel.attributedText = message
        titleLabel.attributedText = title_
        
        messageLabel.font = config.font
        messageLabel.textColor = config.bubbleTextColor
        
        titleLabel.font = config.titleFont
        titleLabel.textColor = config.titleTextColor
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
}

@_functionBuilder
struct ActivateConstraint {
    static func buildBlock(_ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        constraints
    }
}

extension NSLayoutConstraint {
    
    static func activeAll(@ActivateConstraint _ constraints: () -> [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints())
        
    }
}
