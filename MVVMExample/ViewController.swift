//
//  ViewController.swift
//  MVVMExample
//
//  Created by Mehmet Emin Çetin on 15.07.2025.
//  Private öğeler sadece bu sınıf içinden erişilebilir.
//  Override superclass'ın önceden tanımlanmış özelliklerini kendimize göre değiştirmeye olanak tanır
//  Super anahtar kelimesi superclass'ın aynı isimli fonksiyon, özellik eya initializer'ını çağırmak için kullnaılır.
//  amaç init ile üst sınıfın davranışını koruyup ondan sonra kendi yazdığımız değişiklikleri yazmak



import UIKit

class ViewController: UIViewController, UITableViewDataSource {
     
    private var models : [Person] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PersonFollowingTableViewCell.self, forCellReuseIdentifier: PersonFollowingTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        self.title = "Ana Sayfa"
    }
    
    private func configureModel() {
        let names = [
            "Joe", "Dann", "Jeff", "Jenny", "Emily"
        ]
        for name in names {
            models.append(Person(name: name))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingTableViewCell.identifier, for: indexPath) as? PersonFollowingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: PersonFollowingTableViewCellViewModel(with: model))
        cell.delegate = self
        return cell
    }
}

extension ViewController: PersonFollowingTableViewCellDelegate {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
        
    }
}
