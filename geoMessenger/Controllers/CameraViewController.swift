//
//  CameraViewController.swift
//  geoMessenger
//
//  Created by Nicolas Schmidt on 10/30/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit
import Firebase

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgPhoto: UIImageView!
    
    // Storing photos to Firebase
    var storageRef: StorageReference!
    
    // Function for storing content to Firebase
    func configureStorage() {
        let storageUrl = FirebaseApp.app()?.options.storageBucket
        storageRef = Storage.storage().reference(forURL: "gs://" + storageUrl!)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPhoto.image = selectedImage
        } else {
            print("Something went wrong")
        }
        
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnTakePicture_TouchUpInside(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .camera
            imgPicker.allowsEditing = false
            // show the camera App
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSelectPhoto_TouchUpInside(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .photoLibrary
            imgPicker.allowsEditing = true // allow users to crop , etc.
            // show the photoLibrary
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSavePhoto_Touch(_ sender: UIBarButtonItem) {
        let imageData = UIImageJPEGRepresentation(imgPhoto.image!, 0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        
        let guid = "test_id"
        
        let imagePath = "\(guid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        self.storageRef.child(imagePath)
            .putData(imageData!, metadata: metadata) { [weak self] (metadata, error) in
                if let error = error {
                    print ("error uploading: \(error)")
                    return
                }
        }

        
        let ac = UIAlertController(title: "Photo Saved!", message:"The photo was saved successfully!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        //let ac = UIAlertController(title: "Photo Saved!", message: "Your photo was saved sucessfully", preferredStyle: .alert)
        //ac.addAction(UIAlertAction(title: "OK", style: .default))
        //present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStorage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
