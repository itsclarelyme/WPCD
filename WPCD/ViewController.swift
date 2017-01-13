//
//  ViewController.swift
//  WPCD
//
//  Created by Clare Lee on 1/12/17.
//  Copyright © 2017 ThatWasQuick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var projLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var ready: UIButton!
    
    
    var instructions = ["Welcome to Introvert to Extrovert", "So you want to learn how to dance?", "Let me teach you!", "Before we begin, hold your phone in your right hand", "make sure the phone is secure (aka don't throw it please)","Step 1: Look at the images to see how to perform the dance!", "Step 2: Perform the dance until you hear the DING! sound.", "Step 3: To advance to the next dance, tap 'Next Dance'", "Whenever you're ready let me know!"]
    
    var index:Int = 0
    
    @IBAction func nextline(_ sender: UIButton) {
        if index < instructions.count - 1 {
            index += 1
            instructionLabel.text = instructions[index]
            
            if index == instructions.count - 1 {
                nextbtn.isEnabled = false
                nextbtn.setTitleColor(UIColor.gray, for: .normal)
            }
            
        }
        else{
            
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        
        //Initialize Scheme
        self.view.backgroundColor = UIColor (colorLiteralRed: (4.0/255.0), green: (177.0/255.0), blue: (216.0/255.8), alpha: 1.0)
        projLabel.textColor = UIColor.white
        instructionLabel.textColor = UIColor.white
        instructionLabel.text = instructions[index]
        ready.layer.cornerRadius = 10
        
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

