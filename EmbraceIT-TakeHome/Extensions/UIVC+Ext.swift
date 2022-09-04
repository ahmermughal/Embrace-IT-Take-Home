//
//  UIVC+Ext.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/4/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlert(title: String, message: String){
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alertVC, animated: true)
        
    }
    
    
}
