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
    var cows = 0
    var sees = 0
    var bell1: AVAudioPlayer?
    var wpcdtheme: AVAudioPlayer?
    var lock: Float = 0.1
    func bellPlay() {
        print("Playing: bell")
        let sound = NSDataAsset(name: "bell1")!
        
        do {
            bell1 = try AVAudioPlayer(data: sound.data)
            bell1?.enableRate = true
            bell1?.rate = 1.0
            guard let player = bell1 else { return }
            print("Hello")
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func mainPlay() {
        print("Playing: main")
        let sound = NSDataAsset(name: "wpcdtheme")!
        
        do {
            wpcdtheme = try AVAudioPlayer(data: sound.data)
            wpcdtheme?.enableRate = true
            wpcdtheme?.rate = Float(slideOutlet.value)
            guard let player = wpcdtheme else { return }
            print("Hello")
            wpcdtheme?.numberOfLoops = -1
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

    
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var danceimg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var danceImage: UIImageView!
    @IBOutlet weak var slideOutlet: UISlider!
    
    var flip: Int = 0
    var dance:[String] = ["Two Step", "All Eyes On Me", "Milking the Cow", "Now you see me, now you don't"]
    var dancePics: [[String]] = [["1_1.jpg", "1_2.jpg", "1_3.jpg", "1_4.jpg", "1_5.jpg", "1_6.jpg", "1_7.jpg", "1_8.jpg"], ["2_2.jpg", "2_1.jpg", "2_2.jpg", "2_3.jpg", "2_4.jpg", "2_5.jpg", "2_6.jpg", "2_7.jpg"], ["3_1.jpg", "3_2.jpg", "3_3.jpg", "3_4.jpg", "3_1.jpg", "3_2.jpg", "3_3.jpg", "3_4.jpg"],  ["4_1.jpg", "4_2.jpg", "4_3.jpg", "4_4.jpg", "4_1.jpg", "4_2.jpg", "4_3.jpg", "4_4.jpg"]]
    var index: Int = 0
    
    
    @IBAction func nextMove(_ sender: Any) {
        //Update to next move
        iscomplete = false
        
        //initialize the variables
        steps = 0
        eyes = 0
        cows = 0
        sees = 0
        
        if index < dance.count - 1 {
            index += 1
            updateDance()
        }else{
            index = 0
            updateDance()
        }
    }
    
    @IBAction func Slider(_ sender: UISlider) {
        let roundedValue = round(sender.value / lock) * lock
        sender.value = roundedValue
        mainPlay()
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
            if acc.x > 0.6 && rot.z > 0.2{
                print("two steps: ", steps)
                print(acc.x)
                steps += 1
            }
            if steps == 10 {
                self.iscomplete = true
                OperationQueue.main.addOperation{
                    self.bellPlay()
                }
            }
        case 1:
            //print("dance two")
            //All Eyes On Me
        
            if acc.x > 0.75 && rot.z > 10{
                print("All Eyes On Me ", eyes)
                eyes += 1
            }
            if eyes == 7 {
                self.iscomplete = true
                OperationQueue.main.addOperation{
                    self.bellPlay()
                }
            }
        case 2:
            //Milking the cow
            if acc.y > 0.9{
                print("milking cows: ", cows)
                print(acc.y)
                cows += 1
            }
            if cows == 40 {
                self.iscomplete = true
                OperationQueue.main.addOperation{
                    self.bellPlay()
                }
            }
        case 3:
            //Now you see me
            if acc.y > 0.7{
                print("you see me: ", sees)
                print(acc.y)
                sees += 1
            }
            if sees == 25 {
                self.iscomplete = true
                OperationQueue.main.addOperation{
                    self.bellPlay()
                }
            }
            
        
        default:
            print("other dance move")
        }
        
        if self.iscomplete == true {
            OperationQueue.main.addOperation {
                self.statusLabel.text = "Good Job!"
            }
        }
    }
    
    func printPic()
    {
        print("Hello Jeiji")
        danceImage.image = UIImage(named: dancePics[index][flip])
        if flip < dancePics[index].count - 1 {
            flip += 1
        }
        else {
            flip = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var swiftTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: Selector("printPic"), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        nameLabel.text = dance[index]
        statusLabel.text = "Let's Go!"
        nextbtn.layer.cornerRadius = 10
        mainPlay()
        
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
