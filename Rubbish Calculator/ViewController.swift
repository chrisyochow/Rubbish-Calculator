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
    
    enum CalculationOperators: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equal = "="
        case Empty = "Empty"
    }
    
    var btnSoundPlayer: AVAudioPlayer!
    
    var runningNumber = ""
    var leftStrValue = ""
    var rightStrValue = ""
    var resultStrValue = ""
    var currentOperator = CalculationOperators.Empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        let btnSoundPath = Bundle.main.path(forResource: "ButtonSound", ofType: "wav")
        let btnSoundURL = URL(fileURLWithPath: btnSoundPath!)
        
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
        
        if resultStrValue != "" {
            leftStrValue = ""
            rightStrValue = ""
            resultStrValue = ""
            currentOperator = CalculationOperators.Empty
        }

        updateUI()
    }
    
    @IBAction func cancelBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        if runningNumber != "" {
            runningNumber = ""
        } else {
            leftStrValue = ""
            rightStrValue = ""
            resultStrValue = ""
            currentOperator = CalculationOperators.Empty
        }
        
        updateUI()
    }
    
    @IBAction func divideBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        performOperation(btnPressed: CalculationOperators.Divide)
    }
    
    @IBAction func multiplyBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        performOperation(btnPressed: CalculationOperators.Multiply)
    }
    
    @IBAction func subtractBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        performOperation(btnPressed: CalculationOperators.Subtract)
    }
    
    @IBAction func addBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        performOperation(btnPressed: CalculationOperators.Add)
    }
    
    @IBAction func equalBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        performOperation(btnPressed: CalculationOperators.Equal)
    }
    
    @IBAction func dotBtnPressed(sender: UIButton) {
        //playBtnSound()
        
        if runningNumber == "" {
            runningNumber = "0."
        } else {
            if !runningNumber.contains(".") {
                runningNumber += "."
            }
        }
        
        updateUI()
    }
    
    func performOperation(btnPressed: CalculationOperators) {
        if currentOperator == CalculationOperators.Empty || resultStrValue != "" {
            if btnPressed != CalculationOperators.Equal {
                leftStrValue = mainDisplayLabel.text!
                rightStrValue = ""
                resultStrValue = ""
                runningNumber = ""
                currentOperator = btnPressed
            }
            
            print("1")
        } else {
            if runningNumber != "" {
                rightStrValue = runningNumber
                
                if currentOperator == CalculationOperators.Divide {
                    resultStrValue = "\(Double(leftStrValue)! / Double(rightStrValue)!)"
                } else if currentOperator == CalculationOperators.Multiply {
                    resultStrValue = "\(Double(leftStrValue)! * Double(rightStrValue)!)"
                } else if currentOperator == CalculationOperators.Subtract {
                    resultStrValue = "\(Double(leftStrValue)! - Double(rightStrValue)!)"
                } else if currentOperator == CalculationOperators.Add {
                    resultStrValue = "\(Double(leftStrValue)! + Double(rightStrValue)!)"
                }
                
                runningNumber = ""
                
                if btnPressed != CalculationOperators.Equal {
                    leftStrValue = resultStrValue
                    resultStrValue = ""
                    rightStrValue = ""
                }
            }
            
            if btnPressed != CalculationOperators.Equal {
                currentOperator = btnPressed
            }
            
            print("2")
        }
        
        print("btnPressed = \(btnPressed)")
        updateUI()
    }
    
    func updateUI() {
        if resultStrValue != "" {
            operatorLabel.text = "\(leftStrValue) \(currentOperator.rawValue) \(rightStrValue) ="
            mainDisplayLabel.text = resultStrValue
            
            cancelBtn.setTitle("AC", for: UIControlState.normal)
        } else if currentOperator != CalculationOperators.Empty {
            operatorLabel.text = "\(leftStrValue) \(currentOperator.rawValue)"
            if runningNumber != "" {
                mainDisplayLabel.text = runningNumber
                
                cancelBtn.setTitle("C", for: UIControlState.normal)
            } else {
                mainDisplayLabel.text = ""
                
                cancelBtn.setTitle("AC", for: UIControlState.normal)
            }
        } else {
            operatorLabel.text = ""
            if runningNumber != "" {
                mainDisplayLabel.text = runningNumber
            } else {
                mainDisplayLabel.text = "0"
            }
            
            cancelBtn.setTitle("AC", for: UIControlState.normal)
        }
        
        print("runningNumber = \(runningNumber)")
        print("leftStrValue = \(leftStrValue)")
        print("rightStrValue = \(rightStrValue)")
        print("resultStrValue = \(resultStrValue)")
        print("currentOperator = \(currentOperator)")
    }
    
    func playBtnSound() {
        if btnSoundPlayer.isPlaying{
            btnSoundPlayer.stop()
        }
        
        btnSoundPlayer.play()
    }
}
