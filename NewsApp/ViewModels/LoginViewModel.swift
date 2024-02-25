//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 26/2/24.
//

import UIKit
import CoreData

class LoginViewModel {
    
    let context = AppDelegate.content
    
    
    func authenticateUser(username: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            UserDefaults.standard.set(username, forKey: "logedUsername")
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return false
        }
    }
    
    func insertDefaultUserData() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            if users.isEmpty {
                // Insert default user data
                let defaultUser = User(context: context)
                defaultUser.username = "admin"
                defaultUser.password = "admin123"
                
                do {
                    try context.save()
                    
                } catch {
                    print(NAError.coreDataError)
                }
            }
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
    
    
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = Configure.Color.tabbarTintColor
        tabbar.viewControllers = [createNewsNC(),createFavoritesNC()]
        return tabbar
    }
    
    private func createNewsNC() -> UINavigationController {
        let newsVC = NewsVC()
        newsVC.title = NSLocalizedString("Search", comment: "")
        newsVC.tabBarItem = UITabBarItem(title: NSLocalizedString("News", comment: ""), image: UIImage(named: Configure.IconImage.newsIcon), tag: 0)
        return UINavigationController(rootViewController: newsVC)
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesNC = FavoritesVC()
        favoritesNC.title = NSLocalizedString("Search", comment: "")
        favoritesNC.tabBarItem = UITabBarItem(title: NSLocalizedString("Favorites", comment: ""), image: UIImage(named: Configure.IconImage.favoritesFillIcon), tag: 1)
        return UINavigationController(rootViewController: favoritesNC)
    }
}
