//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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
}

let host = GuessNumberHost()
host.isValidNumber(input: "abcd")
host.checkAB(test: "1234", answer: "1234")
