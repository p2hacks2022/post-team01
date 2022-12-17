//
//  SignInView.swift
//  TeddyBear2022
//
//  Created by テディベア on 2022/12/13.
//
// ログイン画面

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var isShowingHView: Bool = false // ホーム画面遷移
    @State private var emailText: String = "" // email情報取得
    
    @State private var isSignedIn = false
    @State private var mailAddress = ""
    @State private var password = ""
    @State private var isShowAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    @State private var isShowSignedOut = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                NavigationLink(destination: HomeView(emailText: emailText), isActive: $isShowingHView) {
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
                    
                    HStack {
                        Spacer().frame(width: 50)
                        VStack(spacing: 16) {
                            if self.isSignedIn {
                                Text("ログインしています").foregroundColor(Color("Color1"))
                                    .font(.system(size: 18, weight: .bold))
                                    .padding()
                            } else {
                                Text("ログインしていません").foregroundColor(Color("Color2"))
                                    .font(.system(size: 18, weight: .bold))
                                    .padding()
                            }
                            
                            TextField("メールアドレス", text: $mailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                                .accentColor(.pink)
                            
                            SecureField("パスワード", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
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
                                } else {
                                    self.signIn()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // サインイン速度に合わせる
                                        if self.isSignedIn {
                                            isShowingHView.toggle()
                                        }
                                    }
                                }
                            }) {
                                Text("ログイン")
                                    .frame(width: 120)
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
                                    return Alert(title: Text(""), message: Text("ログインしました"), dismissButton: .default(Text("OK")))
                                }
                            }
                            Button(action: {
                                self.signOut()
                            }) {
                                Text("ログアウト")
                                    .frame(width: 120)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("Color2"))
                                    .padding(.all, 25)
                                    .background(Color("Color"))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                    .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                                    .accentColor(Color.pink)
                            }
                            .alert(isPresented: $isShowSignedOut) {
                                Alert(title: Text(""), message: Text("ログアウトしました"), dismissButton: .default(Text("OK")))
                            }
                        }
                        Spacer().frame(width: 50)
                    }
                }
            }
            .padding(.all)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
            .onAppear() {
                self.getCurrentUser()
            }
        }
        .navigationBarBackButtonHidden(true) // 戻るボタン削除
    }
    
    private func getCurrentUser() {
        if let _ = Auth.auth().currentUser {
            self.isSignedIn = true
        } else {
            self.isSignedIn = false
        }
    }
    
    private func signIn() {
        Auth.auth().signIn(withEmail: self.mailAddress, password: self.password) { authResult, error in
            if authResult?.user != nil {
                guard let email = Auth.auth().currentUser?.email else {
                    return emailText = "ログインしてない"
                }
                emailText = email
                self.isSignedIn = true
                self.isShowAlert = true
                self.isError = false
            } else {
                self.isSignedIn = false
                self.isShowAlert = true
                self.isError = true
                if let error = error as NSError?{
                    if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                        switch errorCode {
                        case .invalidEmail:
                            self.errorMessage = "メールアドレスの形式が正しくありません"
                        case .userNotFound, .wrongPassword:
                            self.errorMessage = "メールアドレス、またはパスワードが間違っています"
                        case .userDisabled:
                            self.errorMessage = "このユーザーアカウントは無効化されています"
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
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            self.isShowSignedOut = true
            self.isSignedIn = false
        } catch let signOutError as NSError {
            print("SignOut Error: %@", signOutError)
        }
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}

