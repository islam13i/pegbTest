//
//  Alerts.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

class Alerts: NSObject {
    
    static func showAlertDelete(controller: UIViewController, _ message: String, deletion: @escaping () -> Void) {
        let dialogMessage = UIAlertController(title: NSLocalizedString("Deletion Confirmation", comment: ""), message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .default, handler: { (action) in
         deletion()
         })
        deleteAction.setValue(Configure.Color.redColor, forKey: "titleTextColor")
         dialogMessage.addAction(deleteAction)

        dialogMessage.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (action) in
            print("cancel is tapped.")
         }))
         controller.present(dialogMessage, animated: true, completion: {})
    }

    static func showAlert(controller: UIViewController,title:String, message: String, completion: @escaping () -> Void) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (_) in }
        dialogMessage.addAction(okAction)
        controller.present(dialogMessage, animated: true, completion: nil)
    }
}
