//
//  ContentView.swift
//  FormValidation
//
//  Created by Phanit Pollavith on 6/3/21.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var userInfoModel = UserInfoModel()
  @State var validCredentials = false
  @State var modifiedName = ""
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Name")) {
          TextField("First Name", text: $userInfoModel.firstName)
            .onReceive(userInfoModel.addLetterPublisher, perform: { modName in
              modifiedName = modName
            })
          Text("Modified Name: \(modifiedName)")
        }
        
        Section(header: Text("Email")) {
          TextField("Email", text: $userInfoModel.email)
        }
        
        Button(action: {}, label: {
          Text("Button")
        })
        .disabled(!validCredentials)
        .onReceive(userInfoModel.validatedCredentialsPublisher, perform: { isValidUserInfo in
          validCredentials = isValidUserInfo
        })
        
      }
      .navigationBarTitle("Form")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
