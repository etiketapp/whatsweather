//
//  ViewControllerExtension.swift
//  festivalvar
//
//  Created by tunay alver on 13.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - Progress Hud
    func startProgressHud() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
            for view in self.view.subviews{
                view.isUserInteractionEnabled = false
                view.alpha = 0.3
            }
        }
    }
    
    func stopProgressHud() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            for view in self.view.subviews{
                view.isUserInteractionEnabled = true
                view.alpha = 1.0
            }
        }
    }
    
    //MARK: - Navigation Functions
    func emptyNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func setNavigationBarBackButtonEmpty() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Colors.navigationTint
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func addAppIconToNavbar() {
        UINavigationBar.appearance().isTranslucent = false
        
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        logoView.image = UIImage(named: "appLogo30")
        logoView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = logoView
    }
    
    //MARK: - Alert
    func performAlert(title: String, message: String, buttonTitle: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let button = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }
    
    func performAlertWithCompletionDouble(title: String, message: String, buttonTitle: String, button2Title: String, style: UIAlertController.Style, buttonTapped: @escaping () -> Void, button2Tapped: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let button = UIAlertAction(title: buttonTitle, style: .default, handler: {(alert: UIAlertAction!) in buttonTapped()})
        let button2 = UIAlertAction(title: button2Title, style: .default, handler: {(alert: UIAlertAction!) in button2Tapped()})
        alert.addAction(button)
        alert.addAction(button2)
        present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    func performDoubleAlertWithCancel(title: String, message: String, buttonTitle: String, button2Title: String, style: UIAlertController.Style, buttonTapped: @escaping () -> Void, button2Tapped: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let button = UIAlertAction(title: buttonTitle, style: .default, handler: {(alert: UIAlertAction!) in buttonTapped()})
        let button2 = UIAlertAction(title: button2Title, style: .default, handler: {(alert: UIAlertAction!) in button2Tapped()})
        let cancel = UIAlertAction(title: "Vazgeç", style: .cancel, handler: {(alert: UIAlertAction!) in self.dismissAlertController()})
        alert.addAction(button)
        alert.addAction(button2)
        alert.addAction(cancel)
        present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    func performAlertDoubleCompletionNDP(title: String, message: String, buttonTitle: String, button2Title: String, style: UIAlertController.Style, buttonTapped: @escaping () -> Void, button2Tapped: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let button = UIAlertAction(title: buttonTitle, style: .default, handler: {(alert: UIAlertAction!) in buttonTapped()})
        let button2 = UIAlertAction(title: button2Title, style: .default, handler: {(alert: UIAlertAction!) in button2Tapped()})
        alert.addAction(button)
        alert.addAction(button2)
        present(alert, animated: true)
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
