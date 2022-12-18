//
//  MainView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/16
//  
//  スタート画面

import SwiftUI
import FirebaseAuth
import Firebase

struct MainView: View {
    @State private var isShowingSIView: Bool = false // サインイン画面遷移
    @State private var isShowingSUView: Bool = false // サインアップ画面遷移
    var logo: UIImage = UIImage(imageLiteralResourceName: "caplogo") // ロゴ
    @State var emailText = "" // email情報
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                NavigationLink(destination: SignInView(), isActive: $isShowingSIView) {
                                    EmptyView()
                                }
                NavigationLink(destination: SignUpView(), isActive: $isShowingSUView) {
                                    EmptyView()
                                }
                
                ZStack{
                    
                    // ロゴ部分の背景色
                    Color("Color").edgesIgnoringSafeArea(.all)
                    
                    // ロゴ
                    Image(uiImage: logo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 320)
                }
                
                // ログインボタン
                Button(action: {
                    isShowingSIView.toggle()
                }, label: {
                    Text("ログイン")
                        .frame(width: 200)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 25)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                })
                .padding()
                
                // 新規登録ボタン
                Button(action: {
                    isShowingSUView.toggle()
                }, label: {
                    Text("新規登録")
                        .frame(width: 200)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 25)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                })

                Spacer()
                Spacer()
            }
            .padding(.all)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
        }
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
