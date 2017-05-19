//
//  ViewController.swift
//  HelloGuestNumber
//
//  Created by Daniel on 2016/11/26.
//  Copyright © 2016年 Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userGuessTextField: UITextField!
    @IBOutlet weak var inputA: UITextField!
    @IBOutlet weak var inputB: UITextField!
    @IBOutlet weak var logTextView: UITextView!
    var host = GuessNumberHost()
    var ai = GuessNumberAI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logTextView.text = "Welcome,please guess it first.\n"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        guard let userInput = userGuessTextField.text else{
            logTextView.text! += "Invalid empty input.\n"
            return
        }
        guard  host.isValidNumber(input: userInput) else {
            logTextView.text! += "Invalid input:\(userInput)\n"
            return
        }
        // Handle user's input
        guard let resultAB = host.handleUserGuess(input: userInput) else{
            logTextView.text! += "Can't handle input:\(userInput)\n"
            return
        }
        logTextView.text! += "User guess [\(host.userGuessCounter)]:\(userInput) ==> \(resultAB.A)A,\(resultAB.B)B \n"
        // Check if user win the game
        if resultAB.A == host.maxNumbers {
            logTextView.text! += "user win the game!\n"
            return
        }
        // It's AI's turn to gues a number.
        guard  let aiGuess = ai.getAIGuess() else {
            logTextView.text! += "AI don't know how to guess,please restart the game.\n"
            return
        }
        logTextView.text! += "AI Guess [\(ai.aiGuessCounter)]:\(aiGuess) \n"
    }

    @IBAction func replayBtnPressed(_ sender: Any) {
        guard let replyA = inputA.text else{
            logTextView.text! += "Invalid input emptyA.\n"
            return
        }
        guard let replyB = inputB.text else {
            logTextView.text! += "Invalid input emptyB.\n"
            return
        }
        guard replyA.isEmpty == false && replyB.isEmpty == false else {
            logTextView.text! += "A and B cna't be empty.\n"
            return
        }
        guard let replyANumber = Int(replyA) else {
            logTextView.text! += "A is not a valid number.\n"
            return
        }
        guard let replyBNumber = Int(replyB) else {
            logTextView.text! += "B is not a valid number.\n"
            return
        }
        // Handle user's replyAB
        guard let result = ai.handleUserReply(replyA: replyANumber, replyB: replyBNumber) else {
            logTextView.text! += "AI don't know how to guess,please restart the game.\n"
            return
        }
        if result {
        logTextView.text! += "AI Win the game.\n"
        }else {
                  logTextView.text! += "==>\(replyA)A,\(replyB)B\nYour turn to guess.\n"
        }
    }
    
    @IBAction func restartBtnPressed(_ sender: Any) {
        host = GuessNumberHost()
        ai = GuessNumberAI()
        
        logTextView.text = "Game restart! Please guess first.\n"
        userGuessTextField.text = ""
        inputB.text = ""
        inputA.text = ""
    }
    
    func  testTurple(parameter:(A:Int,B:Int)){
        parameter.A
        parameter.B
    }
    
}

