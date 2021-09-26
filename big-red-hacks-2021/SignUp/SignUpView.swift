//
//  SignUpView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/25/21.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                Spacer().frame(height: 20)
                Button(action: {
                    guard !email.isEmpty && !password.isEmpty else {
                        print("Invalid Info!")
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(Color(.white))
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
            }
            .padding()
            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().preferredColorScheme(.dark)
    }
}
