//
//  AlertViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/29/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    // MARK: - Properties
    /// IBOutlet properties
    @IBOutlet private weak var messageLabel: UILabel?
    @IBOutlet weak var buttonsView: UIView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var viewContainer: UIView? {
        didSet { viewContainer?.layer.cornerRadius = 15.0 }
    }
    
    /// Private properties
    fileprivate var actionNames = [String]()
    fileprivate var actionHandler: ((String) -> Void)?
    private var messageText: String = ""
    private var titleText: String = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addActionButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.messageLabel?.text = messageText
        self.titleLabel?.text = titleText
    }
    
    // MARK: - Deinitialization
    deinit { debugPrint("ChatAlertViewController deinit") }

    // MARK: - Methods
    private func button(_ title: String?) -> UIButton  {
        let btn = UIButton.init(type: .system)
        let device = UIDevice.current.userInterfaceIdiom
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: device == .pad ? 20 : 14)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.setTitle(title, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentHorizontalAlignment = .center
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(btnActions(_ :)), for: .touchUpInside)
        return btn
    }
    
    fileprivate func update(_ title: String?, _ message: String?) {
        self.messageText = message ?? ""
        self.titleText = title ?? ""
    }
    
    fileprivate func onlyOkButton(_ title: String? = "OK") {
        let btn = button(title)
        self.buttonsView?.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        self.buttonsView?.addConstraints(NSLayoutConstraint .constraints(withVisualFormat: "V:|[btn]|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: ["btn": btn]))
        self.buttonsView?.addConstraints(NSLayoutConstraint .constraints(withVisualFormat: "H:|[btn]|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: ["btn": btn]))
    }
    
    fileprivate func addActionButtons() {
        if actionNames.isEmpty {
            onlyOkButton()
            return
        }
        
        if actionNames.count == 1 {
            onlyOkButton(actionNames.first)
            return
        }
        
        var tempBtn: UIButton?
        
        for (index, title) in actionNames.enumerated() {
            let btn = button(title)
            buttonsView?.addSubview(btn)
            if tempBtn == nil {
                btn.topAnchor.constraint(equalTo: (buttonsView?.topAnchor)!, constant: 2).isActive = true
                btn.bottomAnchor.constraint(equalTo: (buttonsView?.bottomAnchor)!, constant: -2).isActive = true
                btn.leadingAnchor.constraint(equalTo: (buttonsView?.leadingAnchor)!, constant: 2).isActive = true
                btn.tag = index
                tempBtn = btn
            } else {
                btn.topAnchor.constraint(equalTo: (tempBtn?.topAnchor)!, constant: 0).isActive = true
                btn.bottomAnchor.constraint(equalTo: (tempBtn?.bottomAnchor)!, constant: 0).isActive = true
                btn.leadingAnchor.constraint(equalTo: (tempBtn?.trailingAnchor)!, constant: 5).isActive = true
                btn.widthAnchor.constraint(equalTo: (tempBtn?.widthAnchor)!, multiplier: 1).isActive = true
                if index == actionNames.count - 1 {
                    btn.trailingAnchor.constraint(equalTo: (buttonsView?.trailingAnchor)!, constant: -5).isActive = true
                }
                tempBtn = btn
            }
        }
    }
    
    // MARK: - Actions
    @objc func btnActions(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.actionHandler?(sender.title(for: .normal) ?? "")
    }
    
    // MARK: - Navigation
    fileprivate func show(in parent: UIViewController) {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
        parent.present(self, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    // MARK: - Alert
    func showAlertWith(title: String?,
                              message: String?,
                              actions: [String] = [String](),
                              handler: ((String)->Void)? = nil) {
        let alertVC = AlertViewController(nibName: "\(AlertViewController.self)", bundle: nil)
        alertVC.update(title, message)
        alertVC.actionNames = actions
        alertVC.actionHandler = handler
        alertVC.show(in: self)
    }
}
