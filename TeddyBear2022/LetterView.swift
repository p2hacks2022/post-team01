//
//  LetterView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/15
//  
//

import SwiftUI
import Firebase

struct LetterView: View {
    private static let placeholder = "自由に入力してください"
//    @State private var placeholderText = placeholder
    @Binding var editText: String // テキストを入力する

    @Environment(\.dismiss) var dismiss
    
//    init() {
//            editText = placeholderText
//        }
    
    init(editText: Binding<String>) {
            self._editText = editText
//            self.placeholderText = placeholder
        }
    
    var body: some View {
        VStack{
            ZStack{
                // メニュー
                HStack {
                    // リセットボタン
                    Button(action: {
                        editText = ""
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
                    Spacer()
                }
                Text("お手紙")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color2"))
            }
            .padding()
            
            TextEditor(text: $editText)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 300, height: 200)
                .padding(.all)
                .background(Color("Color").opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            // ニューモーフィズムエフェクト
                .shadow(color: Color("Color1").opacity(0.3), radius: 8, x: 8, y: 8)
                .shadow(color: Color.white, radius: 10, x: -10, y: -10)
                .accentColor(Color.pink)
                
            Spacer()
            
            // 決定ボタン（カプセル画面へ）
            Button(action: {
//                guard let uid = Auth.auth().currentUser?.uid else {
//                    return uidText = "ログインしてない"
//                }
//                uidText = uid
//                Firestore.firestore().collection(uidText).document("capsule1").setData(["letter": editText])
                dismiss()
            }, label: {
                Text("決定")
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
    
}

//struct LetterView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetterView()
//    }
//}
