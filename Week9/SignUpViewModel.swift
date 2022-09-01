//
//  SignUpViewModel.swift
//  Week9
//
//  Created by SC on 2022/09/01.
//

import Foundation

class SignUpViewModel {
    var name: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var isValid: Observable<Bool> = Observable(false)
    
    func checkValidation() {
        if email.value.count >= 6 && password.value.count >= 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signUp(completion: @escaping () -> Void) {
        UserDefaults.standard.set(name.value, forKey: "name")
        completion()
    }
}
