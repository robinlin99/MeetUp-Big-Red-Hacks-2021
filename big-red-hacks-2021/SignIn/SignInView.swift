//
//  SignInView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/25/21.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
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
                        viewModel.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color(.white))
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15)
                    })
                    
                    NavigationLink("Create an Account", destination: SignUpView())
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Sign In")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().preferredColorScheme(.dark)
    }
}