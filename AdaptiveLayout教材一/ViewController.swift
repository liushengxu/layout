//
//  ViewController.swift
//  AdaptiveLayout教材一
//
//  Created by notebook37 on 15/1/12.
//  Copyright (c) 2015年 51auto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testSwiftContacts:Array = getSysContacts()
       
        if testSwiftContacts.isEmpty {
            println("no contact")
        }
        for contact in testSwiftContacts {
            println(contact["FirstName"]!+"·"+contact["LastName"]!)
        }

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

