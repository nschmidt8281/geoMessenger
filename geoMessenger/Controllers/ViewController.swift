//
//  ViewController.swift
//  geoMessenger
//
//  Created by Nicolas Schmidt on 10/30/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtFirstName: HoshiTextField!
    
    @IBOutlet weak var txtLastName: HoshiTextField!
    
    @IBAction func btnAddUser_TouchUpInside(_ sender: CustomButton) {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        let userTable : [String : Any] =
            ["FirstName": txtFirstName.text!,
             "LastName": txtLastName.text!,
             "IsApproved": false]
        
        // add to the Firebase JSON node for MyUsers
        ref.child("MyUsers").childByAutoId().setValue(userTable)
        
        // show confirmation alert
        let ac = UIAlertController(title: "User Saved!", message:"The user information  was saved successfully!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        // reset controls
        txtLastName.text = nil
        txtFirstName.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
