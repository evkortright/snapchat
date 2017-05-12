//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Enrique V. Kortright on 5/3/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            let snap = Snap()
            snap.imgURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.imgDescription = (snapshot.value as! NSDictionary)["description"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.key = snapshot.key
            snap.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
            
            self.snaps.append(snap)
            self.tableView.reloadData()
        })

        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: { (snapshot) in
            print(snapshot)
            
            var i : Int = 0
            for snap in self.snaps {
                if snapshot.key == snap.key {
                    break
                }
                i += 1
            }
            self.snaps.remove(at: i)
            self.tableView.reloadData()
        })
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue: \(String(describing: segue.identifier))")
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        print("logoutTapped")
        dismiss(animated: true, completion: nil)
    }
    
}
