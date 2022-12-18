//
//  GetCapsuleView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/17
//  
//  カプセル閲覧画面

import SwiftUI
import FirebaseAuth
import Firebase
import UIKit

struct GetCapsuleView: View {
    @State var uidText = "ID" // アカウント管理のID
    @State private var letterData = "" // letter
    @State private var dateData = "" // date
    @State private var futureData = "" // future
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationView {
            
            VStack(){
                
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
                        
                        // 更新ボタン
                        Button(action: {
                            guard let uid = Auth.auth().currentUser?.uid else {
                                return uidText = "ログインしてない"
                            }
                            uidText = uid
                            
                            // FIrestoreからデータ取得
                            let db = Firestore.firestore()
                            let docRef = db.collection(uidText).document("1")
                            
                            docRef.getDocument { (document, error) in
                                if let document = document, document.exists {
                                    
                                    if let docDict = document.data(),
                                       
                                       let letter = docDict["letter"] as? String,
                                       let timestamp: Timestamp = docDict["date"] as? Timestamp,
                                       let date: Date? = timestamp.dateValue() {
                                        // 日付の調整
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: "ja_JP")
                                        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                                        dateFormatter.dateStyle = .medium
                                        dateFormatter.dateFormat = "yyyy年 M月dd日 H時mm分"
                                        letterData = "letter: \(letter)"
                                        dateData = "\(dateFormatter.string(from: date!))"
                                        
                                    } else {
                                        dateData = "cannot retrieve data"
                                    }
                                    print("Document data: \(dateData)")
                                } else {
                                    print("Document does not exist")
                                }
                            }
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.gray)
                                .padding(.all, 20)
                                .background(Color("Color"))
                                .clipShape(Circle())
                            // ニューモーフィズムエフェクト
                                .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                        })
                        
                    }
                    Text("思い出そう")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color2"))
                }
                Spacer()
                
                // 取得したデータの表示
                List{
                    Text("\(dateData)\n\(letterData)")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .foregroundColor(Color("Color2"))
                }
                Spacer()
            }
            .padding(.all)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true) // 戻るボタン削除
    }
}


