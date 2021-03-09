//
//  ViewController.swift
//  KLFUserInterfaceGuide
//
//  Created by jebelli.farhad@gmail.com on 08/14/2019.
//  Copyright (c) 2019 jebelli.farhad@gmail.com. All rights reserved.
//

import UIKit
import KLFUserInterfaceGuide

class ViewController: UIViewController {

    @IBOutlet var subView: UIView!
    @IBOutlet var innerSubview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attr = NSMutableAttributedString(string: "title", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.paragraphStyle: style])
        attr.append(NSAttributedString(string: "\nDescripti onDescr iptionDe scriptio nDescriptionDes cript ionDe scription", attributes: [.font: UIFont.systemFont(ofSize: 12)]))
        //self.presentUserInterfaceGuide(view: self.innerSubview, message: attr)
        self.presentUserInterfaceGuide(view: subView, message: attr, dismissWhenTapedOutside: false, decision: { point in
            if self.innerSubview.frame.contains(point) {
                self.subviewTapped()
                return true
            }
            return false
        }, completion: {
            
        })
    }
    
    func subviewTapped() {
        print("subviewTapped")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

