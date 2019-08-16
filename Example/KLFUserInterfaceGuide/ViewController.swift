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
        self.presentUserInterfaceGuide(view: self.innerSubview, message: "This is very begining\n message!!!",tag: "123", dismissWhenTapedOutside: true) {
            print()
        }
        self.presentUserInterfaceGuide(view: self.innerSubview, message: "This is very ") {
            print()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

