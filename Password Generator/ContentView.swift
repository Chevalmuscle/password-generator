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

func getRandomPassword() -> String {
    let len = 16
    let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%?&*(){}[]"
    let password = String((0..<len).compactMap{ _ in chars.randomElement() })
    return password
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
