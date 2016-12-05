//
//  ViewController.swift
//  Rubbish Calculator
//
//  Created by Chris Chow on 29/11/2016.
//  Copyright © 2016 Yau On Chow. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainDisplayLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    var btnSoundPlayer: AVAudioPlayer!
    var runningNumber = ""
    var leftStrValue = ""
    var rightStrValue = ""
    var resultStrVaule = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnSoundPath = Bundle.main.path(forResource: "ButtonSound", ofType: "wav")
        let btnSoundURL = URL(fileURLWithPath: btnSoundPath!)
        
        mainDisplayLabel.text = "0"
        operatorLabel.text = ""
        
        do {
            try btnSoundPlayer = AVAudioPlayer(contentsOf: btnSoundURL)
            btnSoundPlayer.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        runningNumber += "\(sender.tag)"
        mainDisplayLabel.text = runningNumber
    }
    
    @IBAction func cancelBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        runningNumber = ""
        mainDisplayLabel.text = "0"
    }
    
    func playBtnSound() {
        if btnSoundPlayer.isPlaying{
            btnSoundPlayer.stop()
        }
        
        btnSoundPlayer.play()
    }
}
