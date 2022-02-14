//
//  LoginFormController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 31.01.2022.
//

import UIKit
import WebKit
import RealmSwift

class LoginFormController: UIViewController {
    
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let webView = WKWebView()
    
    
    // Отображаем WebView со входом.
    override func loadView() {
        self.view = webView
        webView.navigationDelegate = self
        //webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        if let url = URL(string: "https://oauth.vk.com/authorize?client_id=8068558&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,groups,photos,wall&response_type=token&v=5.131") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    // Осталось из начала туториала...
    // MARK: - Keyboard utils
    // Когда клавиатура появляется.
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры.
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView равный размеру клавиатуры.
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Когда клавиатура исчезает.
    @objc func keyboardWillBeHidden(notification: Notification) {
        // устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления, одно приходит при появлении клавиатуры.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе когда она пропадает.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    
}

extension LoginFormController: WKNavigationDelegate {
    // Рабочий вариант для отображения WebView со входом.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            let correctUrl = urlStr.replacingOccurrences(of: "#", with: "?")
            guard let urlComponents = URLComponents(string: correctUrl) else { return }
            let accessToken = urlComponents.queryItems?.first(where: { $0.name == "access_token" })?.value
            let userId = urlComponents.queryItems?.first(where: { $0.name == "user_id" })?.value
            if accessToken != nil && userId != nil {
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
                // Если это новый пользователь, то надо удалить данные прошлого пользователя.
                if let oldUserId = UserDefaults.standard.string(forKey: "userId") {
                    if oldUserId != userId {
                        // Удаляем старые данные.
                        let realm = try! Realm()
                        try! realm.write {
                            realm.deleteAll()
                        }
                    }
                }
                // Загрузка данных.
                UserDefaults.standard.set(userId, forKey: "userId")
                let vkService = VKService(userId!, accessToken!)
                
                vkService.loadGroupsData(completion: {groups in
                    
                })
                
                vkService.loadFriendsData(completion: {friends in
                    self.performSegue(withIdentifier: "showTabBar", sender: self)
                    print(accessToken ?? "")
                    print(userId ?? "")
                })
                
                
                
            }
            
        }
        decisionHandler(.allow)
    }
}
