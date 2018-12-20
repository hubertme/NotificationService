//
//  ViewController.swift
//  NotificationService-HandsOn
//
//  Created by Hubert Wang on 20/12/2018.
//  Copyright © 2018 Hubert Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNHelper.shared.authorize()
    }
    
    // MARK: - Actions
    @IBAction func onTimerTapped(_ sender: UIButton){
        print("timer")
        
    }
    
    @IBAction func onDateTapped(_ sender: UIButton){
        print("date")
    }
    
    @IBAction func onLocationTapped(_ sender: UIButton){
        print("location")
    }
}

