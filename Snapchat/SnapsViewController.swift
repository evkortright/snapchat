//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Enrique V. Kortright on 5/3/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        print("logoutTapped")
        dismiss(animated: true, completion: nil)
    }
    
}
