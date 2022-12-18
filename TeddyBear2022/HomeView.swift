//
//  HomeView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/16
//  
//  ホーム画面

import SwiftUI
import FirebaseAuth
import Firebase

struct HomeView: View {
    @State private var isShowingCView: Bool = false // カプセル作成画面遷移
    @State private var isShowingC2View: Bool = false // カプセル閲覧画面遷移
    var logo: UIImage = UIImage(imageLiteralResourceName: "caplogo") // ロゴ
    @State var emailText: String // email情報
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {

        NavigationView {
            
            VStack{
                
                // 画面遷移
                NavigationLink(destination: MakeCapsuleView(), isActive: $isShowingCView) {
                                    EmptyView()
                                }
                NavigationLink(destination: GetCapsuleView(), isActive: $isShowingC2View) {
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
                Spacer()
                
                // ロゴ
                Image(uiImage: logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320, height: 320)
                
                Spacer()
                
                // アカウント情報
                Text(emailText)
                    .foregroundColor(Color("Color1"))
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 10)
                Text("でログインしています")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 15, weight: .bold))
                    .padding(.bottom, 50)
                
                HStack{
                    
                    // カプセル作成ボタン
                    Button(action: {
                        isShowingCView.toggle()
                    }, label: {
                        Text("つくる")
                            .frame(width: 90)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("Color2"))
                            .padding(.all, 25)
                            .background(Color("Color"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    })
                    .padding(.trailing, 15)
                    
                    // カプセル閲覧ボタン
                    Button(action: {
                        isShowingC2View.toggle()
                    }, label: {
                        Text("みる")
                            .frame(width: 90)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("Color2"))
                            .padding(.all, 25)
                            .background(Color("Color"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    })
                }
                Spacer()
            }
            .padding(.all)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true) // 戻るボタン削除
    }
}
