//
//  ViewController.swift
//  PractiseWork1Skvortsova
//
//  Created by Kseniya Skvortsova on 10.10.2023.
//

import UIKit

class MainViewController: UIViewController {

    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        return table
    }()
    
    var dataSource: [Product] = []
    
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        
        dataSource = generateData()
        
        view.backgroundColor = .orange
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        
        self.navigationController?.navigationBar.tintColor = .yellow
        
        setupNavigationBar()
        setupLayout()
    }
    
    func generateData()->[Product]{
        let data:[Product] = [Product(id: UUID(), name: "Mitsubishi Outlander, 2017",
                                      subtitle: "Продается Outlander 3 рестайл 2. Полный привод, двигатель - бензиновый 2.0, 146 лошадиных сил. Один владелец, дилерское обслуживание. Текущий пробег 86 500 км.",
                                      price: 2500000,
                                      picImage: UIImage(named: "image1")),
                              Product(id: UUID(), name: "Mercedes-Benz GLA 250, 2020",
                                                            subtitle: "Состояние отличное",
                                                            price: 4300000,
                                                            picImage: UIImage(named: "image2")),
                              Product(id: UUID(), name: "Geely Preface, 2023",
                                                            subtitle: "Привезем автомобиль GEELY PREFACE под заказ из КИТАЯ за 1 месяц с лучшей ценой по РФ.В максимальной комплектации. Пробег 70 км, вы будете первым хозяином в ПТС. ",
                                                            price: 3000000,
                                                            picImage: UIImage(named: "image3")),
                              Product(id: UUID(),name: "LADA (ВАЗ) Granta, 2019",
                                                            subtitle: "Акционная цена, подробности уточняйте у менеджеров",
                                                            price: 490000,
                                                            picImage: UIImage(named: "image4")),]
        return data
    }
//    WEAK
    func setupNavigationBar() {
        let basketAction = UIAction { _ in
            let nextVC = BucketViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        navigationItem.title = "Shop"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .search, primaryAction: basketAction, menu: nil)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath) as! ProductTableViewCell
        
        let product = dataSource[indexPath.row]
        cell.configureCell(with: product)
        cell.backgroundColor = .black
        
        return cell
    }
}


