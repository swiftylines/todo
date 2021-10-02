//
//  PlaceholderTextView.swift
//  ToDoApp
//
//  Created by Manish on 03/10/21.
//

import UIKit

class PlaceholderTextView: UIView {
    
    // MARK: - Properties
    var onTextChange: ((String) -> Void)?
    
    let placeholderText: String
    let placeholderTextColor: UIColor?
    let textFont: UIFont?
    let textColor: UIColor?
    private(set) var text: String
    private(set) var isPlaceholderVisible = false
    
    // MARK: - Views
    private let textView = UITextView()
    
    // MARK: - Init
    init(placeholderText: String = "",
         placeholderTextColor: UIColor? = .lightGray,
         text: String = "",
         textFont: UIFont?,
         textColor: UIColor?) {
        self.placeholderText = placeholderText
        self.placeholderTextColor = placeholderTextColor
        self.text = text
        self.textFont = textFont
        self.textColor = textColor
        
        super.init(frame: .zero)
        
        self.setupViews()
        self.setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.textView.text = self.placeholderText
        self.textView.textColor = UIColor.lightGray
        self.textView.font = self.textFont
        self.textView.delegate = self
        
        self.textView
            .add(to: self)
            .allAnchorsSame(on: self)
    }
    
    func setupData() {
        if self.text.isEmpty {
            self.setupPlaceholderText()
        } else {
            self.textView.text = self.text
        }
    }
    
}

extension PlaceholderTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if !self.isPlaceholderVisible {
            self.text = textView.text
            self.onTextChange?(self.textView.text)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.isPlaceholderVisible {
            self.text = ""
            textView.text = nil
            textView.textColor = self.textColor
            self.isPlaceholderVisible = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.setupPlaceholderText()
        }
    }
    
    func setupPlaceholderText() {
        self.text = ""
        self.textView.text = self.placeholderText
        self.textView.textColor = self.placeholderTextColor
        self.isPlaceholderVisible = true
    }
    
}
