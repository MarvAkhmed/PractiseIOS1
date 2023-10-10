//
//  BucketViewController.swift
//  PractiseWork1Skvortsova
//
//  Created by Kseniya Skvortsova on 10.10.2023.
//

import UIKit

class BucketViewController: UIViewController {
    
    enum TableSection {
        case main
    }
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize:20)
        label.textColor = .black
        label.text="1111"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize:20)
        label.textColor = .black
        label.text="1111"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .singleLine
        table.register(BucketTableViewCell.self, forCellReuseIdentifier: BucketTableViewCell.reuseIdentifier)
        return table
    }()
    
    var products: [Product] = [Product(id: UUID(), name: "Mitsubishi Outlander, 2017",
                                       subtitle: "Продается Outlander 3 рестайл 2. Полный привод, двигатель - бензиновый 2.0, 146 лошадиных сил. Один владелец, дилерское обслуживание. Текущий пробег 86 500 км.",
                                       price: 2500000,
                                       picImage: UIImage(named: "image1"),
                                       Product(id: UUID(), name: "Mitsubishi Outlander, 2017",
                                                                          subtitle: "Продается Outlander 3 рестайл 2. Полный привод, двигатель - бензиновый 2.0, 146 лошадиных сил. Один владелец, дилерское обслуживание. Текущий пробег 86 500 км.",
                                                                          price: 2500000,
                                                                          picImage: UIImage(named: "image1")]
    var dataSource: UITableViewDiffableDataSource<TableSection, Product>?
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        tableView.backgroundColor = .black
        
        setupLayout()
        setupNavigationBar()
        setupDataSource()
    }
    
    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, product in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BucketTableViewCell.reuseIdentifier, for: indexPath) as! BucketTableViewCell
            cell.configureCell(with: product)
            cell.delegate = self
            return cell
        })
        
        updateDataSource(with: products, animate: false)
    }
    
    func updateDataSource(with products: [Product], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products)
        setupLabels()
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
    func setupLabels(){
        var count=0
        var price=0
        
        for prod in products {
            count+=1
            price+=prod.price
        }
        
        countLabel.text="Total count: "+String(count)
        priceLabel.text="Total price: "+String(price)
    }
    
    func setupNavigationBar() {
        
        navigationItem.title = "Bucket"
    }
    
    func setupLayout() {
        let mainStackView = UIStackView(arrangedSubviews: [countLabel, priceLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing=5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
}

extension BucketViewController: BucketCellDelegate {
    func didPressDeleteDisclosure(for product: Product) {
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this product?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            if let objectIndex = self.products.firstIndex(where: { $0.id == product.id }) {
                self.products.remove(at: objectIndex)
                self.updateDataSource(with: self.products, animate: false)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
    }
}

extension BucketViewController: ProductCellDelegate {
    func didPressAddDisclosure(for product: Product) {
        self.products.append(product)
    }
    
}

extension BucketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
