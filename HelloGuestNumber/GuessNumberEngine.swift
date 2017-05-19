//
//  GuessNumberEngine.swift
//  HelloGuestNumber
//
//  Created by Daniel on 2016/11/26.
//  Copyright © 2016年 Daniel. All rights reserved.
//


import Foundation

class GuessNumberBase {
    
    let  maxNumbers = 4
    
    func isValidNumber(input:String) -> Bool {
        // Check Length
        let length = input.characters.count
        guard length == maxNumbers else
        {
            return false
        }
        
        
        //Check if input is a number
        guard Int(input) != nil else {
            return false
        }
        
        //Check if any duplicated digits
        let inputSet = Set(input.characters)
        guard inputSet.count == maxNumbers else {
            return false
        }
        return true
    }
    func checkAB(test:String,answer:String) -> (A:Int,B:Int)? {
        
        //Check test&answer is valid?
        guard isValidNumber(input: test) && isValidNumber(input: answer) else {
            return nil
        }
        
        //Check A & B
        let testArray = Array(test.characters)
        let answerArray = Array(answer.characters)
        var resultA = 0,resultB = 0
        for i in 0..<maxNumbers {
            for j in 0..<maxNumbers{
                //..
                if testArray[i] == answerArray[j]{
                    if i == j{
                        resultA += 1
                    } else{
                        resultB += 1
                    }
                }
            }
        }
        
        return (resultA,resultB)
    }
    
}

class GuessNumberHost:GuessNumberBase{
    private var appNumberString = ""
    private(set) var userGuessCounter = 0
    
    
    override init() {
        super.init()
        generateAppNumberString()
    }
    
    // MARK: -Private Methods
    // TODO: Do someting....
    // FIXME: Fix.....
    private func generateAppNumberString(){
        
        var availables = ["0","1","2","3","4","5","6","7","8","9"]
        for _ in 1...maxNumbers{
            let tmpIndex = Int(arc4random_uniform(UInt32(availables.count)))
            let tmpNumer = availables[tmpIndex]
            appNumberString += tmpNumer
            availables.remove(at: tmpIndex)
        }
        print("App Number String: \(appNumberString)")
    }
    // MARK: - Public Methods
    func handleUserGuess(input:String) -> (A:Int,B:Int)? {
        let resultAB = checkAB(test: input, answer: appNumberString)
        if resultAB != nil{
            userGuessCounter += 1
        }
        return resultAB
    }
    
}

class GuessNumberAI: GuessNumberBase {
    private var allPossibilities = [String]()
    private(set) var lastAIGuessString:String?
    private(set) var aiGuessCounter = 0
    
    override init() {
        super.init()
        generateAllPossibilities()
    }
    
    // MARK: - Private Methods
    private func generateAllPossibilities() {
            // 0000 ~ 9999 => 0123 ~ 9876
        
        for i in 0123...9876 {
            let tmp = String(format: "%04d", i)
            if isValidNumber(input: tmp) {
                allPossibilities.append(tmp)
            }
        }
        print("Total \(allPossibilities.count) possibile numbers.")
    }
    // MARK: - Public Methods
    func getAIGuess() -> String? {
        
        guard allPossibilities.count > 0 else {
            return nil
        }
        let targetIdex = Int(arc4random_uniform(UInt32(allPossibilities.count)))
        lastAIGuessString = allPossibilities[targetIdex]
        aiGuessCounter += 1
        return lastAIGuessString
    }
    
    
    //產生標準註解 opt+com+/ 
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - replyA: <#replyA description#>
    ///   - replyB: <#replyB description#>
    /// - Returns: <#return value description#>
    func  handleUserReply(replyA:Int,replyB:Int) -> Bool? {
        //Check if there is any error
        guard let lastGuess = lastAIGuessString else{
            return nil
        }
        
        guard allPossibilities.count > 0 else {
            return nil
        }
        // Check if AI Win?
        if replyA == maxNumbers{
            return true
        }
        // Filter and keep possibile numbers only.
        var newPossibilities = [String]()
        for tmp in allPossibilities {
            guard let tmpAB = checkAB(test: tmp, answer: lastGuess) else{
                return nil
            }
            if tmpAB.A == replyA && tmpAB.B == replyB{
                newPossibilities.append(tmp)
            }
        }
        allPossibilities = newPossibilities
        print("Total \(allPossibilities.count) possibile number.")
        return false
    }
    
}
