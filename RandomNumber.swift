//How to generate random number 

//1.
let randomValue = drand48() 
//gives random double from 0 to 1 

//2.
let randomValue = drand48() * 10 
//from 0 to 10

//3.
let randomValue = 20 + drand48() * 10 
//from 20 to 30

//4.
let random = arc4random_uniform(10)
//generate random number from 0 to 9 

//5.
let random = arc4random_uniform(11) + 10 
//generate random number from 10 to 20 
//default starting value for this func is 0 and we need to plus to get bigger starting value



//Random color 
let red =  1 + drand48() * 255 
let green =  1 + drand48() * 255 
let blue =  1 + drand48() * 255 
let randomColor = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1.0)
