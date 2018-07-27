//
//  ViewController.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-26.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    var eventsRef: DatabaseReference!
    var event: Event!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    override func viewDidLoad() {
       ref = Database.database().reference()
        eventsRef = ref.child("events")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Test comment

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let title = titleTextField.text, title.count > 0, let time = timeTextField.text, time.count > 0  else {
            return
        }
        let host = UserDefaults.standard.object(forKey: "user") as? String
        event = Event(host: host!, title: title, time: time)
        print(event.title)
        
        let generatedRef = ref.child("events").childByAutoId()
//        generatedRef.setValue(["title": event.title, "time": event.time, "host": event.host])
        generatedRef.setValue(event.getDictionary())
        
        performSegue(withIdentifier: "goToLastScreenSegue", sender: self)
        
        
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue ) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLastScreenSegue" {
            let vc = segue.destination as? EventDetailViewController
            vc?.event = event
        }
    }
}

