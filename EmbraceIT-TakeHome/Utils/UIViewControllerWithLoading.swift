//
//  UIViewControllerWithLoading.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/4/22.
//

import UIKit

class UIViewControllerWithLoading: UIViewController {

    var containerView : UIView!

    func showLoadingView() {
          containerView = UIView(frame: view.bounds)
          view.addSubview(containerView)
          
          containerView.backgroundColor = .systemBackground
          containerView.alpha = 0
          
          UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
          }
          let activityIndicator = UIActivityIndicatorView(style: .large)
          
          containerView.addSubview(activityIndicator)
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
          ])
          activityIndicator.startAnimating()
      }
      
      func dismissLoadingView(){
          DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
          }
      }

}
