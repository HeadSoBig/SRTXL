//
//  DetailViewController.swift
//  私人通讯录
//
//  Created by 王军波 on 16/6/29.
//  Copyright © 2016年 王军波. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var titleText: UITextField!
    
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if person != nil {
            
            nameText.text = person?.name
            phoneText.text = person?.phone
            titleText.text = person?.title
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save(_ sender: AnyObject) {
    }
    

}
