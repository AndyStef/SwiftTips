//simpliest way to create own queue on main thread
let queue = DispatchQueue(label: "com.stef.myQueue")
queue.sync {
  for i in 0..<10 {
      print("Something", i)
   } 
}

for i in 100..< 109 {
  print("Something", i)
}

//Firstly block will finish its work and then it will print other stuff (cause of sync)


queue.async {
  for i in 0..<10 {
      print("Something", i)
   } 
}

for i in 100..< 109 {
  print("Something", i)
}

//Parallel running

//queues on global queue???????????
let queue1 = DispatchQueue(label: "SomeLabel1", qos: .userInitiated)
let queue2 = DispatchQueue(label: "SomeLabel2", qos: .userInitiated)

queue1.async {
  for i in 0..<10 {
      print("Something", i)
   } 
}

queue2.async {
  for i in 0..<10 {
      print("Something", i)
   } 
}

//result is 1 from first, 1 - from second and so on

//all the queues on top are serial

//those will be concurent
let anotherQueue = DispatchQueue(label: "another", qos: .utility, attributes: .concurrent)

anotherQueue.async {
  for i in 0..<10 {
      print("Something", i)
   } 
}

anotherQueue.async {
  for i in 0..<10 {
      print("Something", i)
   } 
}

anotherQueue.async {
  for i in 0..<10 {
      print("Something", i)
   } 
}

//it will be executing all at once

//attribute inactiveQueue make the queue inactive at start
queue.activate() //to start it off


//default queues 
let globalQueue = DispatchQueue.global()
