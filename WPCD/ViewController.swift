//
//  ViewController.swift
//  WPCD
//
//  Created by Clare Lee on 1/12/17.
//  Copyright © 2017 ThatWasQuick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var nextbtn: UIButton!
    
    var instructions = ["Welcome to the app", "So you think you can dance?", "good news: you can't!", "But let me, Nick the dance master, Teach you!", "Before we begin, place your phone on your right hand", "make sure the phone is secure (aka dont throw it please)", "whenever your ready let me know!"]
    
    var index:Int = 0
    
    @IBAction func nextline(_ sender: UIButton) {
        if index < instructions.count - 1 {
            index += 1
            instructionLabel.text = instructions[index]
            
            if index == instructions.count - 1 {
                nextbtn.isEnabled = false
            }
            
        }
        else{
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        instructionLabel.text = instructions[index]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

