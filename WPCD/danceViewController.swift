//
//  danceViewController.swift
//  WPCD
//
//  Created by Clare Lee on 1/12/17.
//  Copyright © 2017 ThatWasQuick. All rights reserved.
//

import UIKit
import CoreMotion

class danceViewController: UIViewController {
    
    var motionManager: CMMotionManager?
    //var userAcc: Any?

    
    @IBOutlet weak var danceimg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var dance:[String] = ["dance1: Raise arm", "dance2"]
    var danceins: [[String]] = [[".img"], [".img"]]
    var index: Int = 0
    
    
    @IBAction func nextMove(_ sender: Any) {
        //Update to next move
        if index < dance.count - 1 {
            index += 1
            updateDance()
        }else{
            index = 0
            updateDance()
        }
    }
    
    
    func updateDance(){
        statusLabel.text = "Let's Go!"
        nameLabel.text = dance[index]
    }
    
    func verifyDance(acc: CMAcceleration){
        //Check if correct dance move
        switch (index)
        {
        case 0:
            //print("UserAcc", acc)
            if acc.y > 0.2
            {
                print("dance1 complete")
                statusLabel.text = "Good Job!"
            }
        case 1:
            print("dance two")
        default:
            print("other dance move")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = dance[index]
        statusLabel.text = "Let's Go!"
        
        
        //CoreMotion initiation
        motionManager = CMMotionManager()
        if let manager = motionManager{
            if manager.isDeviceMotionAvailable{
                print("device motion detected")
                let myq = OperationQueue()
                manager.deviceMotionUpdateInterval = 0.5
                manager.startDeviceMotionUpdates(to: myq){
                    (data: CMDeviceMotion?, error: Error?) in
                    if let myData = data {
                        //myData.userAcceleration
                        self.verifyDance(acc: myData.userAcceleration)
                        //print("mydata: ", myData.userAcceleration)
                        
                        //myData.attitude()
                    }
                }
            }else{
                print("cannot detect motion")
            }
        }
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
