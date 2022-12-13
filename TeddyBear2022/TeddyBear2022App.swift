//
//  TeddyBear2022App.swift
//  TeddyBear2022
//
//  Created by 姜南圭 on 2022/12/12.
//

import SwiftUI
import Firebase

@main
struct TeddyBear2022App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MakeCapsuleView() //最初に表示したい画面
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        // この間に AppDelegate.swift の処理を書く
        FirebaseApp.configure()

        return true
    }
}

struct TestApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
