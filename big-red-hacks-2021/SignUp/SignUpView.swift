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
    @State var name = ""
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Name", text: $name)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    TextField("Email Address", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    Spacer().frame(height: 20)
                    Button(action: {
                        guard !email.isEmpty && !password.isEmpty && !name.isEmpty else {
                            print("Invalid Info!")
                            return
                        }
                        viewModel.signUp(name: name, email: email, password: password)
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(Color(.white))
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Spacer()
                }
                .padding()
            }.navigationBarTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().preferredColorScheme(.dark)
    }
}
