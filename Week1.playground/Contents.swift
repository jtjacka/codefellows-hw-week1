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
let removeX = "xJxexxxxfxxxfxxxfxxx"
var toArray = Array(removeX)

//Index for While Loop
var i = 0

while i <= toArray.count{
  if i == 0 {
    //Continue
    i++
  } else if i == toArray.count - 1 {
    //End of String
    break
  } else {
    //remove x character
    if toArray[i] == "x" {
      toArray.removeAtIndex(i)
      continue
    } else {
      i++
    }
  }
}

var backToString = String(toArray)


//MARK: Data Structure Thursday
class Queue <T>{
  
  private var arrayQueue = [T]()
  
  init(first : T) {
    arrayQueue.append(first)
  }
  
  func queue(newItem : T){
    arrayQueue.insert(newItem, atIndex: 0)
  }
  
  func dequeue() -> T {
    let dequeueObject : T = arrayQueue.removeLast()
    return dequeueObject
  }
}

var queueTest = Queue(first: "First")
queueTest.queue("Second")
queueTest.queue("Third")
queueTest.dequeue()
queueTest


//Remove _normal from address

var url = "http://pbs.twimg.com/profile_images/420664623537205248/2EOCvLZW_normal.jpeg"

url = url.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

print(url)


