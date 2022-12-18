//
//  MakeCapsuleView.swift
//  TeddyBear2022
//
//  Created by テディベア on 2022/12/13.
//
// カプセル作成画面

import SwiftUI
import FirebaseAuth
import Firebase

struct MakeCapsuleView: View {
    // 画面遷移用
    @State private var isShowingIView: Bool = false // ImageVIew
    @State private var isShowingVView: Bool = false // VideoView
    @State private var isShowingLView: Bool = false // LetterView
    @State private var isShowingHView: Bool = false // HomeView
    @State private var isShowingDView: Bool = false // DatePickerView
    @Environment(\.dismiss) var dismiss
    
    @State var uidText = "ID" // アカウント管理のID
    
    @State private var editText: String = "" // LetterViewの値
    
    var body: some View {
        
        NavigationView {
            
            VStack(){
                
                NavigationLink(destination: DatePickerView(), isActive: $isShowingDView) {
                    EmptyView()
                }
                
                ZStack{
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
                    Text("思い出を詰めよう")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color2"))
                }
                .padding(.bottom, 50)
                
                // ボタン
                VStack(spacing: 40){
                    
                    // ボタン1段目
                    HStack(spacing: 50){
                        // 写真ボタン（写真セレクト画面へ）
                        Button(action: {isShowingIView.toggle()}, label: {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0)
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color("Color2"))
                                .padding(.all, 30)
                                .background(Color("Color"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                            
                        })
                        .sheet(isPresented: $isShowingIView) {
                            ImageView()
                        }
                        // 動画ボタン（動画セレクト画面へ）
                        Button(action: {isShowingVView.toggle()}, label: {
                            Image(systemName: "video.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0)
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color("Color2"))
                                .padding(.all, 30)
                                .background(Color("Color"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                            
                        })
                        .sheet(isPresented: $isShowingVView) {
                            VideoView()
                        }
                    }
                    
                    // ボタン2段目
                    HStack(spacing: 50){
                        // 音楽ボタン（音楽セレクト画面へ）未実装
                        Button(action: {}, label: {
                            Image(systemName: "headphones")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0)
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color("Color2"))
                                .padding(.all, 30)
                                .background(Color("Color"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                            
                        })
                        // 連絡先ボタン（連絡先セレクト画面へ）未実装
                        Button(action: {}, label: {
                            Image(systemName: "person.2.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0)
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color("Color2"))
                                .padding(.all, 30)
                                .background(Color("Color"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                            
                        })
                    }
                    
                    // ボタン3段目
                    HStack(spacing: 50){
                        // お手紙ボタン（テキスト入力画面へ）
                        Button(action: {isShowingLView.toggle()}, label: {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0)
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color("Color2"))
                                .padding(.all, 30)
                                .background(Color("Color"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                            
                        })
                        .sheet(isPresented: $isShowingLView) {
                            LetterView(editText: $editText)
                        }
                        // ファイルボタン（ファイルセレクト画面へ）未実装
                        Button(action: {}, label: {
                            Image(systemName: "doc.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0)
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color("Color2"))
                                .padding(.all, 30)
                                .background(Color("Color"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                            
                        })
                    }
                }
                Spacer()
                
                // データベースへ中身追加ボタン（日付画面遷移）
                Button(action: {
                    guard let uid = Auth.auth().currentUser?.uid else {
                        return uidText = "ログインしてない"
                    }
                    uidText = uid
                    // IDごとにカプセル追加（if文でカプセルの名前作れば良い？）未実装
                    // お手紙
                    Firestore.firestore().collection(uidText).document("1").setData(["letter": editText])
                    isShowingDView.toggle()
                }, label: {
                    Text("いれる")
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
            .padding(.all)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true) // 戻るボタン削除
    }
    
    struct MakeCapsuleView_Previews: PreviewProvider {
        static var previews: some View {
            MakeCapsuleView()
        }
    }
}
