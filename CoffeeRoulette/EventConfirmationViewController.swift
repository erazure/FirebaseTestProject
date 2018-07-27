//
//  EventConfirmationViewController.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-27.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import UIKit

class EventConfirmationViewController: UIViewController{
    var firebaseStuff: FirebaseStuff!
    var globalEvent: Event!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseStuff = FirebaseStuff()
        timeLabel.text = globalEvent.time
        titleLabel.text = globalEvent.title
        print(#line, globalEvent.eventID)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLastScreenSegue" {
            let vc: EventDetailViewController = segue.destination as! EventDetailViewController
            vc.event = globalEvent
           
            //guest23 wouldn't be hardcoded
            UserDefaults.standard.set("GUEST23", forKey: "guest")
            
            vc.event.guest = (UserDefaults.standard.object(forKey: "guest") as? String)!
            vc.event.catchPhrase = "testing"
            
            
        }
    }

    
    @IBAction func tryAgainButtonPressed(_ sender: UIButton) {
        firebaseStuff.randomEvent{ (event) in
            guard let event = event else { return }
            DispatchQueue.main.async {
                self.globalEvent = event
                self.titleLabel.text = self.globalEvent.title
                self.timeLabel.text = self.globalEvent.time
            }
    }
        
    }
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
//        globalEvent = Event(host: UserDefaults.standard.object(forKey: "user") as! String, title: titleLabel.text!, time: timeLabel.text!)
        firebaseStuff.guestConfirming(globalEvent)
    }
    
}
