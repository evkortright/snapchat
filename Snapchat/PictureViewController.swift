//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Enrique V. Kortright on 5/3/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    @IBAction func cameraTapped(_ sender: Any) {
        print("cameraTapped")
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController")
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        pictureImageView.image = image
        pictureImageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func nextTapped(_ sender: Any) {
        print("nextTapped")
        nextButton.isEnabled = false
        let imagesFolder = FIRStorage.storage().reference().child("images")
//        let imageData = UIImagePNGRepresentation(pictureImageView.image!)!
        let imageData = UIImageJPEGRepresentation(pictureImageView.image!, 0.1)!
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil) { (metadata, error) in
            print("Attempting to upload image to Firebase")
            if (error != nil) {
                print("Error preparing image: \(String(describing: error))")
            } else {
                print("downloadURL: \(String(describing: metadata?.downloadURL()))")
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
        
    }
}
