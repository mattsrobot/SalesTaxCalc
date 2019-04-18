//
//  CalculatorViewController.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private(set) var viewModel: CalculatorViewModel
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productLabelTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField! {
        didSet {
            addAccessoryView(costTextField)
        }
    }
    @IBOutlet weak var quantityTextField: UITextField! {
        didSet {
            addAccessoryView(quantityTextField)
        }
    }
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CalculatorViewController", bundle: .main)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    @objc func didTapCancel() {
        viewModel.didTapCancel?()
    }
    
    @objc func didTapDone() {
        viewModel.didTapDone?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func didUpdateTextField(_ sender: UITextField) {
        
        if sender == productLabelTextField {
            viewModel.productLabel = sender.text
            return
        }
        
        if sender == costTextField {
            guard let text = sender.text else {
                viewModel.price = 0.0
                return
            }
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .decimal
            guard let number = formatter.number(from: text) else {
                viewModel.price = 0.0
                return
            }
            viewModel.price = number.doubleValue
            return
        }
        
        if sender == quantityTextField {
            guard let text = sender.text, let quantity = Int(text) else {
                viewModel.quantity = 0
                return
            }
            
            viewModel.quantity = quantity
            return
        }
    }
    
    func bindViewModel() {
        productLabelTextField.text = viewModel.productLabel
        quantityTextField.text = String(viewModel.quantity)
        costTextField.text = String(viewModel.price)
        navigationItem.rightBarButtonItem?.isEnabled = viewModel.rightButtonEnabled
        
        viewModel.canAddProduct = { [weak self] isEnabled in
            self?.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CalculatorViewController.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CalculatorViewController.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        bindViewModel()
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard var keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        var contentInset = scrollView.contentInset
        contentInset.bottom = view.safeAreaInsets.bottom
        scrollView.contentInset = contentInset
    }
    
    private func addAccessoryView(_ textField: UITextField) {
        let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 0, height: 44))
        toolbar.setItems([UIBarButtonItem(barButtonSystemItem: .done,
                                          target: textField,
                                          action: #selector(UITextField.resignFirstResponder))],
                         animated: false)
        textField.inputAccessoryView = toolbar
    }
    
    deinit {
        print("deinit CalculatorViewController")
    }

}

extension CalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
