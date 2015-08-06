// Jeff Jacka - CodeFellows iOS Development Accelerator - Week 1


// MARK: Monday
var arrayToReverse : [String] = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];

for i in 0..<(arrayToReverse.count/2) {
    
    //Temporarily store original index values
    var swapStorage = arrayToReverse[i];
    var swapStorageEnd = arrayToReverse[(arrayToReverse.count-1)-i]
    
    //Swap Variables
    arrayToReverse[i]=swapStorageEnd
    arrayToReverse[(arrayToReverse.count-1)-i]=swapStorage
    
}

arrayToReverse
// MARK: Tuesday
for i in 1...100 {
  if ((i % 3 == 0)  && (i % 5 == 0)){
    println("FizzBuzz")
  } else if (i % 3 == 0) {
    println("Fizz")
  } else if (i % 5 == 0) {
    println("Buzz")
  } else {
    //Do nothing
  }
}

//MARK: Wednesday
let stringToAnalyze = "thisthisthisthishihihi"
let stringToArray = Array(stringToAnalyze)
var count = 0

for i in 0..<stringToArray.count {
  println(i)
  if (stringToArray[i]  == "h" && stringToArray[i+1] == "i") {
    count++
  }
}

println(count)

//MARK: Thursday
let removeX = "xJxexfxfx"
var toArray = Array(removeX)

for i in 0..<toArray.count {
  println(i)
  if i == 0 {
    //Continue
  } else if i == toArray.count - 1 {
    //End of String
    break
  } else {
    //remove x character
    if toArray[i] == "x" {
      toArray.removeAtIndex(i)
    }
  }
}

var backToString = String(toArray)