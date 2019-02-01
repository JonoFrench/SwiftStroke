//
//  ViewController.swift
//  SwiftStroke
//
//  Created by Jonathan French on 28/01/2019.
//  Copyright © 2019 Jaypeeff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sView:strokeView = strokeView.init(frame: self.view.frame)
        sView.isUserInteractionEnabled = true
        self.view.addSubview(sView)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}

