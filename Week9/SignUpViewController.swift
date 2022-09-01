//
//  SignUpViewController.swift
//  Week9
//
//  Created by SC on 2022/09/01.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.name.bind { text in
            self.nameTextField.text = text
        }
        
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.signUpButton.isEnabled = bool
            self.signUpButton.backgroundColor = bool ? .systemPink : .lightGray
        }
    }
    
    // Editing Changed: 쓸 때마다 지속적으로 확인
    @IBAction func nameTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.name.value = nameTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    

    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        viewModel.signUp {
            // 화면전환 코드
        }
    }
    
}
