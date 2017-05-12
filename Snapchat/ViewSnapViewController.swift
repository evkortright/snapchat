//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Enrique V. Kortright on 5/5/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgDescription: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewSnapViewController.viewDidLoad")
        print("snap: \(snap)")
        imgDescription.text = snap.imgDescription
        imgView.sd_setImage(with: URL(string: snap.imgURL))
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            if (error != nil) {
                print("Error deleting picture from Firebase: \(error!)")
            }
        }
    }
}
