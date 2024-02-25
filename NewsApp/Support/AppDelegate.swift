//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    static var content =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }
    
    private func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = Configure.Color.tabbarTintColor
        tabbar.viewControllers = [createNewsNC(),createFavoritesNC()]
        return tabbar
    }
    
    private func createNewsNC() -> UINavigationController {
        let newsVC = NewsVC()
        newsVC.title = NSLocalizedString("News App", comment: "")
        newsVC.tabBarItem = UITabBarItem(title: NSLocalizedString("News", comment: ""), image: UIImage(named: Configure.IconImage.newsIcon), tag: 0)
        return UINavigationController(rootViewController: newsVC)
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesNC = FavoritesVC()
        favoritesNC.title = NSLocalizedString("Favorites", comment: "")
        favoritesNC.tabBarItem = UITabBarItem(title: NSLocalizedString("Favorites", comment: ""), image: UIImage(named: Configure.IconImage.favoritesFillIcon), tag: 1)
        return UINavigationController(rootViewController: favoritesNC)
    }
    
    // MARK: - Core Data stack
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

