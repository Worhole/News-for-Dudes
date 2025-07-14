//
//  AppDelegate.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    lazy var persistentContainer:NSPersistentContainer = {
        let conteiner = NSPersistentContainer(name: "NewsStorageModel")
        conteiner.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("db is created \(String(describing: description.url))")
            }
        }
        conteiner.viewContext.automaticallyMergesChangesFromParent = true
        return conteiner
    }()
    
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            } catch {
                let error = error as NSError
                fatalError(error.localizedDescription)
            }
        }
    }

}

