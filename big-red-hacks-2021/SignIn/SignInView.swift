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
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.red, Color.blue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    VStack {
                        Spacer()
                            .frame(height: 50)
                        Image("meetup_500x500")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125, height: 125)
                            .cornerRadius(12)
                        Spacer()
                            .frame(height: 50)
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
                            guard !email.isEmpty && !password.isEmpty else {
                                print("Invalid Info!")
                                return
                            }
                            viewModel.signIn(email: email, password: password)
                        }, label: {
                            Text("Log In")
                                .bold()
                                .padding()
                        })
                        .frame(width: 200, height: 50)
                        .background(Capsule().stroke(gradient, lineWidth: 2).saturation(1.8))
                        Spacer()
                        Group {
                            HStack {
                                VStack {
                                    Divider()
                                }.padding()
                                Text("OR")
                                VStack {
                                    Divider()
                                }.padding()
                            }
                        }
                        NavigationLink("Create an Account", destination: SignUpView())
                    }
                    .padding()
                }
                .navigationTitle("Log In")
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().preferredColorScheme(.dark)
    }
}
