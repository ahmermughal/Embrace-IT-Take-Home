//
//  ViewController.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import UIKit

class CityListVC: UIViewController {
    
    private static let CellReuseID = "CityCellID"
    
    private let tableView = UITableView()
    
    private let cities = ["Copenhagen, Denmark", "Lodz, Poland", "Brussels, Belgium", "Islamabad, Pakistan", "Current Location"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        layoutUI()
    }
    
}

extension CityListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityListVC.CellReuseID, for: indexPath)
        
        cell.textLabel?.text = cities[indexPath.row]
        
        return cell
        
    }
    
    
}

// MARK: UI Setup
extension CityListVC{
    
    private func configureVC(){
        title = "Select City"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CityListVC.CellReuseID)
    }
    
    private func layoutUI(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
}

