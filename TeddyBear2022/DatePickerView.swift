//
//  DatePickerView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/17
//  
// カプセルを届ける日付を選択する画面

import SwiftUI
import FirebaseAuth
import Firebase

struct DatePickerView: View {
    
    @State private var isShowingCView: Bool = false // コンプリート画面遷移
    @State var date = Date() // 選択している日付
    @State var uidText = "ID" // アカウント管理のID
    @State private var editText: String = "" // LetterViewの値
    
    @Environment(\.dismiss) var dismiss
    
    init() {
        // カレンダーの色変更
        UIDatePicker.appearance().tintColor = .systemPink
    }
    
    var body: some View {
        
        VStack(){
            
            NavigationLink(destination: CompleteView(), isActive: $isShowingCView) {
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
                Text("タイムカプセルを開ける日")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color2"))
            }
            .padding(.bottom, 50)
            
            // カレンダー
            DatePicker("Select Date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
            
            // 楽に日時を決められるボタン
            HStack(spacing: 20){
                
                // 今の日時から1年後ボタン
                Button(action: {
                    date = Date().addingTimeInterval(60 * 60 * 24 * 365)
                }, label: {
                    Text("1年後")
                        .frame(width: 50)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 20)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                })
                
                // 3年後ボタン
                Button(action: {
                    date = Date().addingTimeInterval(60 * 60 * 24 * 365 * 3)
                }, label: {
                    Text("3年後")
                        .frame(width: 50)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 20)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                })
                
                // 5年後ボタン
                Button(action: {
                    date = Date().addingTimeInterval(60 * 60 * 24 * 365 * 5)
                }, label: {
                    Text("5年後")
                        .frame(width: 50)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 20)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                })
            }
            Spacer()
            
            // データベースへ日時追加ボタン（日付画面遷移）
            Button(action: {
                guard let uid = Auth.auth().currentUser?.uid else {
                    return uidText = "ログインしてない"
                }
                uidText = uid
                // 日時データ
                Firestore.firestore().collection(uidText).document("1").updateData([
                    "date": Timestamp(date: Date()),
                    "future": Timestamp(date: date)
                ])
                                isShowingCView.toggle()
            }, label: {
                Text("リープする")
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
        .navigationBarBackButtonHidden(true) // 戻るボタン削除
    }
}

