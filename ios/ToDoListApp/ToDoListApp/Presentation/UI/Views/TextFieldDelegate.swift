//
//  TextFieldDelegate.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        var info = [String: Any]()
        info["textCount"] = textField.text?.count
        NotificationCenter.default.post(name: CardUseCase.NotificationName.didUpdateTextField, object: self, userInfo: info)
    }
}
