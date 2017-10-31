//
//  TablesTabBarViewController.swift
//  geoMessenger
//
//  Created by Nicolas Schmidt on 10/30/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit

class TablesTabBarViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.barTintColor = UIColor(red: 0.70, green: 0.97, blue: 0.91, alpha: 1.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
