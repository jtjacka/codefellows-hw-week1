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