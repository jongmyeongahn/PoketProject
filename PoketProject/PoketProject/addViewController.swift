//
//  addViewController.swift
//  PoketProject
//
//  Created by arthur on 7/18/24.
//

import UIKit
import SnapKit
import CoreData

class addViewController: UIViewController {
    
    private let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    private let navLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "연락처 추가"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 100
        image.layer.borderWidth = 2
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.gray.cgColor
        return image
    }()
    
    private let randomImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        // UIButtonConfiguration 설정
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        return button
    }()

    
    let nameField: UITextField = {
        let nameField = UITextField()
        nameField.textColor = .black
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 20)
        ]
        nameField.attributedPlaceholder = NSAttributedString(string: "이름을 입력해 주세요.", attributes: placeholderAttributes)
        nameField.textAlignment = .center
        nameField.font = .boldSystemFont(ofSize: 20)
        nameField.layer.cornerRadius = 10
        nameField.layer.borderWidth = 3
        nameField.layer.borderColor = UIColor.black.cgColor
        return nameField
    }()
    
    let phoneField: UITextField = {
        let phoneField = UITextField()
        phoneField.textColor = .systemBlue
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 20)
        ]
        phoneField.attributedPlaceholder = NSAttributedString(string: "핸드폰 번호를 입력해주세요.", attributes: placeholderAttributes)
        phoneField.textAlignment = .center
        phoneField.font = .boldSystemFont(ofSize: 20)
        phoneField.layer.cornerRadius = 10
        phoneField.layer.borderWidth = 3
        phoneField.layer.borderColor = UIColor.black.cgColor
        return phoneField
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameField.delegate = self
        self.phoneField.delegate = self
        configureUI()
        
    
    }
    // 서버 데이터를 불러오는 메서드 , 일반적인 데이터를 사용하기 위해서 제너릭을 사용 무수히 많은 API 들어올수 있기 때문에
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil else {
                print("데이터 로드 실패")
                completion(nil) // 디코딩된 데이터를 넣고 싶으나 실패하면 넣어줄게 없으니 nil 값 넣음
                return
            }
            // http status code 성공범위는 200번대
            let successRange = 200..<300
            if let response = response as? HTTPURLResponse, //  HTTPURL 안에 http status code 깔기 위해 사용
            successRange.contains(response.statusCode) {
               // 서버의 데이터가 제이슨 형태임으로 스위프트의 클래스 또는 구조체로 디코딩 해야됨 성공할시 여기꺼 작동함.
                guard let decodeData = try? JSONDecoder().decode( T.self, from: data) else {
                    print("JSON 디코딩 실패")
                    completion(nil)
                    return
                }
                completion(decodeData  )
            }else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()
        
    }

    @objc private func randomImageButtonTappedrandomImageButtonTapped() {
        let randomNum = Int.random(in: 1...1000)
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNum)") else {
            print("url is not correct")
            return
        }
        
        //비동기 데이터 가지고 오기
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error { 
                print("data error \(error.localizedDescription)")
                return
            }
            
            guard let data = data  else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let sprites = json["sprites"] as? [String: Any],
                   let urlString = sprites["front_default"] as? String,
                   let imageUrl = URL(string: urlString) {
                    
                    DispatchQueue.main.async {
                        self?.profileImage.load(url: imageUrl)
                    }
                }
            } catch _ {
                print("json decoding error")
            }
            
            
        }.resume()
    }
    

    
    private func configureUI() {
        view.backgroundColor = .white
        [
           navLabel,
           profileImage,
           randomImageButton,
           nameField,
           phoneField
        ].forEach { view.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        randomImageButton.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        randomImageButton.addTarget(self, action: #selector(randomButtonAction), for: .touchUpInside)
        
        nameField.snp.makeConstraints {
            $0.top.equalTo(randomImageButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        phoneField.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        
        // Done 버튼 누르면 첫 화면으로 이동
        let rightButton2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveContact))
//        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(backToMain))
        //네비게이션 바 연결
//        self.navigationItem.titleView = navLabel
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem = rightButton2
        
    }
    
    @objc
    private func randomButtonAction(_ sender: UIButton) {
        if let text = sender.currentTitle {
            if text == "랜덤 이미지 생성" {
                randomImageButtonTappedrandomImageButtonTapped()
            }
        }
    }
    
    // 첫화면으로 돌아가는 네비게이션
    @objc func backToMain() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

}


extension addViewController: UITextFieldDelegate {
    
    // UITextFieldDelegate 메서드 - 리턴 버튼이 눌렸을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            // 첫 번째 텍스트 필드에서 리턴 버튼을 눌렀을 때 두 번째 텍스트 필드로 포커스 이동
            phoneField.becomeFirstResponder()
        } else if textField == phoneField {
            // 두 번째 텍스트 필드에서 리턴 버튼을 눌렀을 때 키보드 숨기기
            phoneField.resignFirstResponder()
        }
        return true
    }
    
}

extension UIImageView {
    func load(url: URL) {
        //background thread
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

extension addViewController {
    
    @objc private func saveContact() {
        guard let name = nameField.text, !name.isEmpty,
              let phoneNumber = phoneField.text, !phoneNumber.isEmpty else {
            // 유효성 검사 실패 시 알림 표시 등 처리
            return
        }
        
        let context = persistentContainer.viewContext
        let contact = PhoneBook(context: context)
        contact.name = name
        contact.number = phoneNumber
        if let image = profileImage.image, let imageData = image.pngData() {
            contact.imageUrl = imageData
        }
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .didAddContact, object: nil)
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save contact: \(error)")
        }
    }
}

extension Notification.Name {
    static let didAddContact = Notification.Name("didAddContact")
}
