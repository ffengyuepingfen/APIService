//
//  DefaultSendRequest.swift
//  APIService
//
//  Created by Laowang on 2023/11/23.
//

import UIKit

//MARK: - 结果处理
public enum DefaultAPIError: Error {
    
    case customError(_ code: String,_ message: String)
    
}

func k_keyWindow() -> UIWindow? {
    if let w =  UIApplication.shared.connectedScenes
        .compactMap({ $0 as? UIWindowScene }).first?.windows.first {
            return w
        }
    guard let w = UIApplication.shared.delegate?.window else {
        return nil
    }
    return w
}

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
            let toastLabel = UILabel()
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center
            toastLabel.font = UIFont.systemFont(ofSize: 16)
            toastLabel.text = message
            toastLabel.alpha = 0.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            
            let padding: CGFloat = 16.0 // 左右边距
            let maxWidth = self.view.frame.width - 2 * padding // 最大宽度
            let maxLabelSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
            let expectedLabelSize = toastLabel.sizeThatFits(maxLabelSize)
            let toastWidth = expectedLabelSize.width + 2 * padding
            
            let maxHeight = self.view.frame.height * 0.5 // 高度限制为屏幕高度的50%
            let toastHeight = min(expectedLabelSize.height + 2 * padding, maxHeight)
            
            toastLabel.frame = CGRect(x: (self.view.frame.width - toastWidth) / 2, y: self.view.frame.height - toastHeight - 162, width: toastWidth, height: toastHeight)
            self.view.addSubview(toastLabel)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                toastLabel.alpha = 1.0
            }, completion: {(isCompleted) in
                UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseIn, animations: {
                    toastLabel.alpha = 0.0
                }, completion: {(isCompleted) in
                    toastLabel.removeFromSuperview()
                })
            })
        }
}
