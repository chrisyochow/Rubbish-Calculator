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
    @IBOutlet weak var cancelBtn: UIButton!
    
    enum CalcOperator: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSoundPlayer: AVAudioPlayer!
    var runningNumber = ""
    var leftStrValue = ""
    var rightStrValue = ""
    var resultStrVaule = ""
    var currentOperator = CalcOperator.Empty

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

        if operatorLabel.text != "" && mainDisplayLabel.text != "" && resultStrVaule == "" {
            mainDisplayLabel.text = ""
            
            cancelBtn.setTitle("AC", for: UIControlState.normal)
        } else {
            mainDisplayLabel.text = "0"
            operatorLabel.text = ""
            leftStrValue = ""
            rightStrValue = ""
            resultStrVaule = ""
            currentOperator = CalcOperator.Empty
        }
        
        runningNumber = ""
    }
    
    @IBAction func divideBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        processCalculation(calcOperator: CalcOperator.Divide)
    }
    
    @IBAction func multiplyBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        processCalculation(calcOperator: CalcOperator.Multiply)
    }
    
    @IBAction func subtractBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        processCalculation(calcOperator: CalcOperator.Subtract)
    }
    
    @IBAction func addBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        processCalculation(calcOperator: CalcOperator.Add)
    }
  
    func processCalculation(calcOperator: CalcOperator) {
        if currentOperator != CalcOperator.Empty && runningNumber != "" {
            rightStrValue = runningNumber
            
            if currentOperator == CalcOperator.Divide {
                resultStrVaule = "\(Double(leftStrValue)! / Double(rightStrValue)!)"
            } else if currentOperator == CalcOperator.Multiply {
                resultStrVaule = "\(Double(leftStrValue)! * Double(rightStrValue)!)"
            } else if currentOperator == CalcOperator.Subtract {
                resultStrVaule = "\(Double(leftStrValue)! - Double(rightStrValue)!)"
            } else if currentOperator == CalcOperator.Add {
                resultStrVaule = "\(Double(leftStrValue)! + Double(rightStrValue)!)"
            }
            
            runningNumber = ""
            leftStrValue = resultStrVaule
            rightStrValue = ""
            resultStrVaule = ""
            currentOperator = calcOperator
        } else {
            if runningNumber != "" {
                leftStrValue = mainDisplayLabel.text!
            } else if resultStrVaule != "" {
                leftStrValue = resultStrVaule
            }
            
            runningNumber = ""
            currentOperator = calcOperator
        }
        
        updateUI()
    }
    
    func updateUI() {
        if resultStrVaule != "" {
            operatorLabel.text = "\(leftStrValue) \(currentOperator.rawValue) \(rightStrValue) ="
            mainDisplayLabel.text = resultStrVaule
        } else {
            if currentOperator != CalcOperator.Empty {
                operatorLabel.text = "\(leftStrValue) \(currentOperator.rawValue)"
                
                if runningNumber != "" {
                    mainDisplayLabel.text = runningNumber
                } else {
                    mainDisplayLabel.text = ""
                }
            } else {
                operatorLabel.text = ""
                mainDisplayLabel.text = "0"

            }
        }
    }
    
    func playBtnSound() {
        if btnSoundPlayer.isPlaying{
            btnSoundPlayer.stop()
        }
        
        btnSoundPlayer.play()
    }
}
