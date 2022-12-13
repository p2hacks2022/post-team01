//
//  SignUpView.swift
//  TeddyBear2022
//
//  Created by 姜南圭 on 2022/12/13.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State private var mailAddress = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    
    @State private var isShowAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    
    var body: some View {
       
        HStack {
            Spacer().frame(width: 50)
            VStack {
                TextField("メールアドレス", text: $mailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("パスワード", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("パスワード確認", text: $passwordConfirm).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    self.errorMessage = ""
                    if self.mailAddress.isEmpty {
                        self.errorMessage = "メールアドレスが入力されていません"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.password.isEmpty {
                        self.errorMessage = "パスワードが入力されていません"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.passwordConfirm.isEmpty {
                        self.errorMessage = "確認パスワードが入力されていません"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.password.compare(self.passwordConfirm) != .orderedSame {
                        self.errorMessage = "パスワードと確認パスワードが一致しません"
                        self.isError = true
                        self.isShowAlert = true
                    } else {
                        self.signUp()
                    }
                }) {
                    Text("ユーザー登録")
                }
                .alert(isPresented: $isShowAlert) {
                    if self.isError {
                        return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK"))
                        )
                    } else {
                        return Alert(title: Text(""), message: Text("登録されました"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            Spacer().frame(width: 50)
        }
    }
    
    private func signUp() {
        Auth.auth().createUser(withEmail: self.mailAddress, password: self.password) { authResult, error in
            if let error = error as NSError?{
                
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .invalidEmail:
                        self.errorMessage = "メールアドレスの形式が正しくありません"
                    case .emailAlreadyInUse:
                        self.errorMessage = "このメールアドレスは既に登録されています"
                    case .weakPassword:
                        self.errorMessage = "パスワードは６文字以上で入力してください"
                    default:
                        self.errorMessage = error.domain
                    }
                    
                    self.isError = true
                    self.isShowAlert = true
                }
                
                if let _ = authResult?.user {
                    self.isError = false
                    self.isShowAlert = true
                }
            }
        }
    }
    
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView()
        }
    }
}
