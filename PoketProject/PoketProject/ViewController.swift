//
//  ViewController.swift
//  PoketProject
//
//  Created by arthur on 7/18/24.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    var phoneBook: [PhoneBook] = []
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer

    private let friendListLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchContacts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchContacts), name: .didAddContact, object: nil)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        [
         friendListLabel,
         addButton,
         tableView
         
        ].forEach { view.addSubview($0) }
        
        friendListLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(75)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        addButton.addTarget(self, action: #selector(addVCButton), for: .touchUpInside)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(friendListLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(50)
        }

    }
    
    @objc func fetchContacts() {
        let phoneBooks = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
        
        do {
             phoneBook = try phoneBooks.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func addVCButton() {
        let addVC = addViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    // 다음 화면 넘어가지 전까지 네비게이션 감추기 - 버튼이 네비게이션바 때문에 안눌려져셔 사용
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    // 다음 화면 넘어가면 네비게이션바 나오게 하기
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as?
                TableViewCell else {
            print(#function)
            return UITableViewCell()
        }
        let phoneBooks = phoneBook[indexPath.row]
        
        cell.textLabel?.text = "\(phoneBooks.name ?? "No Name") - \(phoneBooks.number ?? "No Phone")"
        
        if let imageData = phoneBooks.imageUrl {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phoneBook.count
    }
    
}

