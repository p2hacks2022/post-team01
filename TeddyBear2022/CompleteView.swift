//
//  CompleteView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/18
//  
//

import SwiftUI
import FirebaseAuth

struct CompleteView: View {
    
    @State private var isShowingHView: Bool = false // ホーム画面遷移
    @State private var emailText: String = "" // email情報取得
    
    var cloud: UIImage = UIImage(imageLiteralResourceName: "cloud") // ロゴ
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                // ロゴ
                Image(uiImage: cloud)
                    .resizable()
                    .scaledToFill()
//                    .frame(width: 270, height: 270)
                
                VStack(){
                    
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
                    
                    Text("コンプリート！")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color2"))
                    
                    Spacer()
                    
                    // Homeへ
                    Button(action: {
                        guard let email = Auth.auth().currentUser?.email else {
                            return emailText = "ログインしてない"
                        }
                        emailText = email
                        isShowingHView.toggle()
                    }, label: {
                        Text("ホームに戻る")
                            .frame(width: 200)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("Color2"))
                            .padding(.all, 25)
                            .background(Color("Color"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    })
                }
//                .padding(.all)
//                .background(Color("Color").edgesIgnoringSafeArea(.all))
            }
            .padding(.all)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true) // 戻るボタン削除
    }
}
