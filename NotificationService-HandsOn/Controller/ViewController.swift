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
        AlertHelper.actionSheet(in: self, title: "5 Seconds") {
            UNHelper.shared.timerRequest(with: 5)
        }
    }
    
    @IBAction func onDateTapped(_ sender: UIButton){
        print("date")
        AlertHelper.actionSheet(in: self, title: "Some future time") {
            var components = DateComponents()
            components.second = 0
            UNHelper.shared.dateRequest(with: components)
        }
    }
    
    @IBAction func onLocationTapped(_ sender: UIButton){
        print("location")
        AlertHelper.actionSheet(in: self, title: "Coming soon") {
            // Some setup for location
        }
    }
}

