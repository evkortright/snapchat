//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Enrique V. Kortright on 5/3/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        print("signInTapped")
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if (error != nil) {
                print("Error signing in: \(error!)... attempting to create user...")
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    if (error != nil) {
                        print("Error creating user: \(error!).")
                    } else {
                        print("Created user: \(user!)")
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        print("created user in Firebase")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            } else {
                print("Signed in: \(user!)")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
    }
    
}
