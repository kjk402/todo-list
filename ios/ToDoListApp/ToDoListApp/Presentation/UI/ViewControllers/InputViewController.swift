//
//  InputViewController.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/10.
//

import UIKit
import Combine

class InputViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enrollmentButton: UIButton!
    @IBOutlet var inputTextFields: [UITextField]! {
        didSet {
            inputTextFields.forEach { textField in
                textField.delegate = textFieldDelegate
            }
        }
    }
    
    private var loadDataSubject = PassthroughSubject<Void,Never>()
    private var textFieldPublisher: AnyCancellable!
    private var textFieldDelegate = TextFieldDelegate()
    private var cardViewModel: CardViewModel?
    private var mode: String?
    private var columnId: Int?
    private var id: Int?
    private var willEditCard: CardManageable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enrollmentButton.isEnabled = false
        enrollmentButton.backgroundColor = .systemGray5
        setupTitle()
        setTextFieldSubscriber()
    }
    
    private func setTextFieldSubscriber() {
        textFieldPublisher = NotificationCenter.default
            .publisher(for: CardUseCase.NotificationName.didUpdateTextField)
            .sink { notification in
                DispatchQueue.main.async {
                    self.isEnableEnrollment(notification)
                }
            }
    }
    
    private func setupTitle() {
        let title = mode == "add" ? "새로운 카드 추가" : "카드 수정"
        self.titleLabel.text = title
    }
    
    func setupCardViewModel(_ viewModel: CardViewModel) {
        self.cardViewModel = viewModel
    }
    
    func setupMode(_ mode: String) {
        self.mode = mode
    }
    
    func setupColumnId(_ columnId: Int) {
        self.columnId = columnId
    }
    
    func setupWillEditCard(_ willEditCard: CardManageable) {
        self.willEditCard = willEditCard
    }
    
    func setupId(_ id: Int) {
        self.id = id
    }
    
    func bind() {
        if mode == "add" {
            cardViewModel?.addEventListener(loadData: loadDataSubject.eraseToAnyPublisher(), columnId: self.columnId ?? 0)
        } else {
            cardViewModel?.editEventListener(loadData: loadDataSubject.eraseToAnyPublisher(), willEditCard: willEditCard!, toBeTitle: inputTextFields[0].text!, toBeContents: inputTextFields[1].text!)
        }
    }
    
    private func isEnableEnrollment(_ notification: Notification) {
        guard let dict = notification.userInfo as Dictionary? else { return }
        if let count = dict["textCount"] as? Int {
            if self.cardViewModel?.isEnabledCardEnrollemnt(count: count) ?? false {
                self.enrollmentButton.isEnabled = true
                enrollmentButton.backgroundColor = .systemBlue
            } else {
                self.enrollmentButton.isEnabled = false
                enrollmentButton.backgroundColor = .systemGray5
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: .none)
    }
    
    @IBAction func enrollmentButtonTapped(_ sender: UIButton) {
        bind()
        loadDataSubject.send()
        self.dismiss(animated: false, completion: .none)
    }
}
