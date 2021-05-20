//
//  AppDelegate.swift
//  Marvel1.0
//
//  Created by beatriz de souza santos on 5/19/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Ponto de substituição para personalização após o lançamento do aplicativo.
        return true
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Chamado quando uma nova sessão de cena está sendo criada.
        // Use este método para selecionar uma configuração para criar a nova cena.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Chamado quando o usuário descarta uma sessão de cena.
        // Se alguma sessão foi descartada enquanto o aplicativo não estava em execução, isso será executado. application:didFinishLaunchingWithOptions.
        // Use este método para liberar qualquer recurso que sao específicos para as cenas descartadas, pois eles não retornarão.
    }


}

