//
//  Created by Andy Stef on 1/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//


//func to validate email
func validateEmail(candidate: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
}
