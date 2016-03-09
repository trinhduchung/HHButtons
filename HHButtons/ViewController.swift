//
//  ViewController.swift
//  HHButtons
//
//  Created by Hung on 3/7/16.
//  Copyright © 2016 HH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var loadingButton: HHLoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadingButton.backgroundColor = UIColor.orangeColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didLoadingButtonPress(sender: AnyObject) {
        loadingButton.showLoading()
        loadingButton.performSelector("hideLoading", withObject: nil, afterDelay: 2.0)
    }

}

