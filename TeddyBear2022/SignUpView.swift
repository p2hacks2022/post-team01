//
//  SignUpView.swift
//  TeddyBear2022
//
//  Created by 姜南圭 on 2022/12/13.
//
//  新規登録画面

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var isShowingH2View: Bool = false // ホーム画面遷移
    @State private var emailText: String = "eeeee" // email情報取得
    
    @State private var mailAddress = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var isShowAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                NavigationLink(destination: HomeView(emailText: emailText), isActive: $isShowingH2View) {
                    EmptyView()
                }
                
                // メニュー
                HStack{
                    // 戻るボタン（トップ画面へ）
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.all, 20)
                            .background(Color("Color"))
                            .clipShape(Circle())
                        // ニューモーフィズムエフェクト
                            .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    })
                    Spacer()
                }
                
                ZStack{
                    
                    Color("Color").edgesIgnoringSafeArea(.all)
                    
                    // 入力ボックス
                    HStack {
                        Spacer().frame(width: 50)
                        VStack {
                            TextField("メールアドレス", text: $mailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                                .accentColor(.pink)
                            SecureField("パスワード", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                                .accentColor(.pink)
                            SecureField("パスワード確認", text: $passwordConfirm).textFieldStyle(RoundedBorderTextFieldStyle())
                                .accentColor(.pink)
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
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // サインアップ速度に合わせる
                                        if self.isError == false {
                                            isShowingH2View.toggle()
                                        }
                                    }
                                }
                            }) {
                                Text("ユーザー登録")
                                    .frame(width: 150)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("Color2"))
                                    .padding(.all, 25)
                                    .background(Color("Color"))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                    .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                                    .accentColor(Color.pink)
                                    .padding(.all)
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
            }
            .padding(.all)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true) // 戻るボタン削除
    }
    
    private func signUp() {
        Auth.auth().createUser(withEmail: self.mailAddress, password: self.password) { authResult, error in
            if let _ = authResult?.user {
                guard let email = Auth.auth().currentUser?.email else {
                    return emailText = "登録してない"
                }
                emailText = email
                print("あああああああ\(emailText)")
                self.isError = false
                self.isShowAlert = true
            } else {
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
                }
            }
        }
    }
}
