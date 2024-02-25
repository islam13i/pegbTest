//
//  Toast.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit
import SnapKit

fileprivate var containerView: UIView!

extension UIViewController {

    func showToast(title:String ,text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
        alert.dismiss(animated: true, completion: nil)
        })
    }

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        self.view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {
        containerView.alpha = 0.8
            }
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.snp.makeConstraints { (make) in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview()
        activityIndicator.startAnimating()
        }
    }

    func dismissLoadingView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
}
