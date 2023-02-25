//
//  ContentView.swift
//  CheckMyPassword
//
//  Created by Putut Yusri Bahtiar on 25/02/23.
//

import CommonCrypto
import SwiftUI

struct ContentView: View {
    @State private var password = ""
    @State private var isPasswordInList = false
    
    var body: some View {
        VStack {
            Spacer()
            Image("lock")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 30)
            
            Text("Check My Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("Enter your password to check if it has been leaked in a data breach.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
            
            TextField("Password", text: $password)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .autocapitalization(.none)
                .onChange(of: password) { newPassword in
                    isPasswordInList = checkPasswordInList(newPassword)
                }
            
            Button(action: {
                isPasswordInList = checkPasswordInList(password)
            }) {
                Text("Check Password")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            
            if let resultText = resultText {
                Text(resultText)
                    .font(.headline)
                    .padding(.top, 30)
                    .foregroundColor(isPasswordInList ? .red : .green)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    var resultText: String? {
        if password.isEmpty {
            return nil
        }
        
        if isPasswordInList {
            return "Your password has been found in a data breach."
        } else {
            return "Your password has not been found in any data breaches."
        }
    }
    
    func checkPasswordInList(_ password: String) -> Bool {
        guard let fileURL = Bundle.main.url(forResource: "passwordlist", withExtension: "txt") else {
            print("Password list file not found!")
            return false
        }
        
        let passwordList = try! String(contentsOf: fileURL, encoding: .utf8)
        return passwordList.contains(password)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
