//
//  ViewController.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import UIKit

class CityWeatherListVC: UIViewController {
    
    private let tableView = UITableView()
    
    private let cities = ["Copenhagen, Denmark", "Lodz, Poland", "Brussels, Belgium", "Islamabad, Pakistan", "Current Location"]
    
    private var viewModel : CityWeatherListViewModel
    
    init(viewModel : CityWeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        layoutUI()
    }
    
}

extension CityWeatherListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailsCell.ReuseID, for: indexPath)
        
        return cell
        
    }
    
    
}


// MARK: UI Setup
extension CityWeatherListVC{
    
    private func configureVC(){
        title = Constants.String.weather
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.register(WeatherDetailsCell.self, forCellReuseIdentifier: WeatherDetailsCell.ReuseID)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func layoutUI(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
}

