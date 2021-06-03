//
//  UserInfoModel.swift
//  FormValidation
//
//  Created by Phanit Pollavith on 6/3/21.
//

import Foundation
import Combine

class UserInfoModel: ObservableObject {
  @Published var firstName = ""
  @Published var email = ""
}

// MARK: - Validations

extension UserInfoModel {
  
  var validatedCredentialsPublisher: AnyPublisher<Bool, Never> {
    $firstName.combineLatest($email) { firstName, email in
      let isValidEmail = EmailValidator.isValid(email: email)
      let isValidFirstName = !firstName.isEmpty
      return isValidEmail && isValidFirstName
    }
    .eraseToAnyPublisher()
  }
  
  var addLetterPublisher: AnyPublisher<String, Never> {
    $firstName.map { firstName in
      return firstName + "-a"
    }
    .eraseToAnyPublisher()
  }
}


extension NSRegularExpression {
  struct Constants {
    static let emailPattern = "([A-Za-z0-9._+-]+)@([a-zA-Z0-9.-]+\\.[a-zA-Z0-9-]+)"
  }
}

struct EmailValidator {
  static func isValid(email: String) -> Bool {
    let emailRegex = NSRegularExpression.Constants.emailPattern
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }
}
