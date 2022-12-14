//
//  ViewController.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import UIKit
import CoreLocation

class CityWeatherListVC: UIViewControllerWithLoading {
    
    // MARK: Views
    private let tableView = UITableView()

    
    // MARK: Variables
    private var gotCurrentLocation = false
    private var viewModel : CityWeatherListViewModel
    private let locationManager = CLLocationManager()
    
    // MARK: Init
    init(viewModel : CityWeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        layoutUI()
    }
    
}

// MARK: ViewModel Delegate
extension CityWeatherListVC: CityWeatherListViewModelDelegate{
    func updateLoading(showLoader: Bool) {
        if showLoader {showLoadingView()} else {dismissLoadingView()}
    }
    
    func errorOccured(error: Error) {
        print("Error Occured")
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    
    func responseCompleted() {
        tableView.reloadData()
    }
    
    
}

// MARK: Tableview delegate
extension CityWeatherListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tempByCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailsCell.ReuseID, for: indexPath) as! WeatherDetailsCell
        
        cell.setup(data: viewModel.tempByCities[indexPath.row])
        
        return cell
        
    }
    
    
}

// MARK: Location Manager delegate
extension CityWeatherListVC: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            viewModel.getWeatherData()
            break
        case .authorizedAlways:
            // This scenaio wont run
            break
        case .authorizedWhenInUse:
            showLoadingView()
            manager.requestLocation()
        @unknown default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if !gotCurrentLocation{
            if let location = locations.first {
                gotCurrentLocation = true
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                viewModel.getWeatherData(latlong: "\(latitude),\(longitude)")
            }
        }

    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user???s location
        print(error.localizedDescription)
        viewModel.getWeatherData()
    }
    
}

// MARK: UI Setup
extension CityWeatherListVC{
    
    private func configureVC(){
        title = Constants.String.weather
        navigationController?.navigationBar.prefersLargeTitles = true
        locationManager.delegate = self

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            viewModel.getWeatherData()
            break
        case .authorizedAlways:
            // This scenaio wont run
            break
        case .authorizedWhenInUse:
            showLoadingView()
            locationManager.requestLocation()
        @unknown default:
            break
        }
        
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.register(WeatherDetailsCell.self, forCellReuseIdentifier: WeatherDetailsCell.ReuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
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

