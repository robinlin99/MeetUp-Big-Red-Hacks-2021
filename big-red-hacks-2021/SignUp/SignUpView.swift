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
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.red, Color.blue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

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
                        guard !email.isEmpty, !password.isEmpty, !name.isEmpty else {
                            print("Invalid Info!")
                            return
                        }
                        viewModel.signUp(name: name, email: email, password: password)
                    }, label: {
                        Text("Sign Up")
                            .bold()
                            .padding()
                    })
                    .frame(width: 200, height: 50)
                    .background(Capsule().stroke(gradient, lineWidth: 2).saturation(1.8))
                    Spacer()
                }
                .padding()
            }.navigationBarTitle("Sign Up")
        }
    }
}
