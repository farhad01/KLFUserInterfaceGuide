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
        self.presentUserInterfaceGuide(view: self.subView, message: "This is very begining message!!!", dismissWhenTapedOutside: true) {
            print()
        }
        self.presentUserInterfaceGuide(view: self.innerSubview, message: "This is another message!!!")
        self.presentUserInterfaceGuide(view: subView, message: "This is very begining message!!!", dismissWhenTapedOutside: false, decision: { point in
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

