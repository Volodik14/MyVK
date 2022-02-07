//
//  LoginFormController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 31.01.2022.
//

import UIKit
import WebKit
import RealmSwift

class LoginFormController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let webView = WKWebView()
    
    
    // TODO: Удалить. Больше не используется.
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        // проверяем верны ли входные данные.
        if checkUserData() {
            print("успешная авторизация")
        } else {
            print("неуспешная авторизация")
        }
        
    }
    
    // Рабочий вариант для отображения WebView.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            let correctUrl = urlStr.replacingOccurrences(of: "#", with: "?")
            guard let urlComponents = URLComponents(string: correctUrl) else { return }
            let accessToken = urlComponents.queryItems?.first(where: { $0.name == "access_token" })?.value
            let userId = urlComponents.queryItems?.first(where: { $0.name == "user_id" })?.value
            //print(urlComponents.queryItems)
            //print(correctUrl)
            
            if accessToken != nil && userId != nil {
                let vkService = VKService(userId!, accessToken!)
                
                vkService.loadGroupsData(completion: {groups in
                    //MyData.shared.groups = groups
                    //print(MyData.shared.groups.count)
                })
                 /*
                vkService.loadPhotosData(completion: {photos in
                    //MyData.shared.photo = photos
                    //print(MyData.shared.photo.count)
                })
                 */
                vkService.loadFriendsData(completion: {friends in
                    //MyData.shared.users = friends
                    self.performSegue(withIdentifier: "showTabBar", sender: self)
                    print(accessToken ?? "")
                    print(userId ?? "")
                })
                
                myData.accessToken = accessToken!
                myData.userId = userId!
                
            }
            
        }
        decisionHandler(.allow)
    }
    
    
    
    override func loadView() {
        self.view = webView
        webView.navigationDelegate = self
        //webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        if let url = URL(string: "https://oauth.vk.com/authorize?client_id=8068558&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.131") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func checkUserData() -> Bool {
        let login = loginInput.text!
        let password = passwordInput.text!
        
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    
    //TODO: Удалить.
    func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    /*
     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
     
     
     // Проверяем данные
     let checkResult = checkUserData()
     
     // если данные неверны, покажем ошибку
     if !checkResult {
     showLoginError()
     }
     
     // вернем результат
     return checkResult
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        // Do any additional setup after loading the view.
    }
    
    // когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        // получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // добавляем отступ внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления, одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе когда она пропадает
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
