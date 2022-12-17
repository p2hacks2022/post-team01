//
//  GetCapsuleView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/17
//  
//  カプセル閲覧画面

import SwiftUI
import FirebaseAuth

struct GetCapsuleView: View {
    
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
                    }
                    Text("思い出そう")
                        .fontWeight(.bold)
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
