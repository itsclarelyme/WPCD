//
//  danceViewController.swift
//  WPCD
//
//  Created by Clare Lee on 1/12/17.
//  Copyright © 2017 ThatWasQuick. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class danceViewController: UIViewController {
    
    var motionManager: CMMotionManager?
    var iscomplete: Bool = false
    var steps = 0
    var eyes:Int = 0
    var player: AVAudioPlayer?

    
    @IBOutlet weak var danceimg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var imgLabel: UILabel!
    @IBOutlet weak var danceImage: UIImageView!
    
    var flip: Int = 0
    var dance:[String] = ["Two Step", "All Eyes On Me"]
    var dancePics: [[String]] = [["1_1.jpg", "1_2.jpg", "1_3.jpg", "1_4.jpg"], [".img"]]
    var index: Int = 0
    var delaydisplay = [[1, 2, 3, 4], [5, 6, 7, 8]]
    
    
    @IBAction func nextMove(_ sender: Any) {
        //Update to next move
        iscomplete = false
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
        let imgq = OperationQueue()
        imgq.addOperation {
            //self.delayDis()
        }
    }
    
    func verifyDance(motion: CMDeviceMotion){
        //Check if correct dance move
        let acc = motion.userAcceleration
        let rot = motion.rotationRate
        
        switch (index)
        {
        case 0:
            //Two Step
            if acc.x > 0.2 && rot.z > 0.2{
                steps += 1
            }
            if steps > 10 {
                self.iscomplete = true
            }
        case 1:
            //print("dance two")
            //All Eyes On Me
        
            if acc.x > 2 && rot.z > 10{
                print("All Eyes On Me ", eyes)
                eyes += 1
            }
            if eyes > 10 {
                self.iscomplete = true
                OperationQueue.main.addOperation {
                    self.statusLabel.text = "Good Job!"
                }
                
            }
            
        
        default:
            print("other dance move")
        }
    }
    
    func printPic()
    {
        print("Hello Jeiji")
        danceImage.image = UIImage(named: dancePics[index][flip])
        if flip < dancePics[index].count {
            flip += 1
        }
        else {
            flip = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var swiftTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("printPic"), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        nameLabel.text = dance[index]
        statusLabel.text = "Let's Go!"
        
        
        //CoreMotion initiation
        motionManager = CMMotionManager()
        if let manager = motionManager{
            if manager.isDeviceMotionAvailable{
                print("device motion detected")
                let myq = OperationQueue()
                
                manager.deviceMotionUpdateInterval = 0.05
                manager.startDeviceMotionUpdates(to: myq){
                    (data: CMDeviceMotion?, error: Error?) in
                    if let myData = data {
                        //myData.userAcceleration
                        //print("lets verify: ", myData.userAcceleration.x)
                        self.verifyDance(motion: myData)
                        
                        
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
