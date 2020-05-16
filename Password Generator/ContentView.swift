//
//  ContentView.swift
//  Password Generator
//
//  Created by Marc-Antoine Jean on 2020-04-13.
//  Copyright © 2020 Marc-Antoine Jean. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var password = "Password"
    
    var body: some View { VStack {
        Text(password)
            .frame(width: 140.0)
        Button(action: {
            self.password = getRandomPassword()
            let pasteBoard = NSPasteboard.general
            pasteBoard.clearContents()
            pasteBoard.setString(self.password, forType: .string)
        }) {
        Text("Generate")
        }
    }
    .padding(20.0)
    }
}

/**
 Enumation of errors for invalid parameters
 */
enum InvalidParameterError: Error {
    /**
     Integer has a value of less than 1
     */
    case NonPositiveIntError
}

/**
 Generates a random password.
 
 - Returns:
    A strong password validated by the `isValidPassword(password: String, requiredLength: Int)` function
 */
func getRandomPassword() -> String {
    let passwordLength = 16
    let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%?&*(){}[]"
    var password: String
    
    // makes sure the password is strong enough
    repeat {
        password = String((0..<passwordLength).compactMap{ _ in chars.randomElement() })
    } while(try! !isValidPassword(password: password, requiredLength: passwordLength))
    
    return password
}

/**
 Checks if the password is strong enough.
 
 - Parameters:
    - password: the password that needs to be validated
    - requiredLength: the length tha the password need to be
 
 - Returns:
    true if the password has:
    - at least 2 upper case letters
    - at least 1 special case letter (!@#$%?&*(){}[])
    - at least 2 digits
    - at least 3 lower case letters
    - a length of requiredLength
 */
func isValidPassword(password: String, requiredLength: Int) throws -> Bool {
    if (requiredLength < 1) {
        throw InvalidParameterError.NonPositiveIntError
    }
    
    // 2+ upper case letters, 1+ special case letter, 2+ digits, 3+ lower case letters, is of length 'requiredLength'
    let passwordRegex = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$%?&*(){}\\[\\]])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{\(requiredLength)}$"
    return password.range(of: passwordRegex, options: .regularExpression, range: nil, locale: nil) != nil ? true: false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
