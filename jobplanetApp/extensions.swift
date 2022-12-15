//
//  extensions.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit


extension String {
    
    // String을 Date형식으로
    func toDate(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 로케일 변경
        formatter.dateFormat = format //2020-02-14 17:52:17
        return formatter.date(from: self)
    }
}

extension Date {
    
    // Date를 String형식으로
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 로케일 변경
        formatter.dateFormat = format //2020-02-14 17:52:17
        return formatter.string(from: self)
    }
}

// MARK: - Reactive
public extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
      }
    
    var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
      }
    
}

extension Reactive where Base: UIView {
    var hide: Binder<Void> {
        return Binder(base) { base, _ in
            base.isHidden = true
        }
    }
    var show: Binder<Void> {
        return Binder(base) { base, _ in
            base.isHidden = false
        }
    }
}
extension Reactive where Base: UITextField {
    var removeText: Binder<Void> {
        return Binder(base) { base, _ in
            base.text = ""
        }
    }
}

// MARK: - UIViewController
extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
}
