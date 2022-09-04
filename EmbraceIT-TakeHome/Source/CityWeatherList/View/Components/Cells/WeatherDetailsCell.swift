//
//  WeatherDetailCell.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import UIKit

class WeatherDetailsCell: UITableViewCell {

    static let ReuseID = "WeatherDetailsCellID"
    
    private let cityNameLabel = UILabel()
    private let windAvgLabel = UILabel()
    private let windMedianLabel = UILabel()
    private let tempAvgLabel = UILabel()
    private let tempMedianLabel = UILabel()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        layoutUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(data: TempByCity){
        
        cityNameLabel.text = "City: \(data.city)"
        windAvgLabel.text = "Avg Wind: \(String(format: "%.2f", data.avgWindSpeed))"
        windMedianLabel.text = "Median Wind: \(String(format: "%.2f", data.medianSpeed))"
        tempAvgLabel.text = "Avg Temp: \(String(format: "%.2f", data.avgTemp))"
        tempMedianLabel.text = "Median Temp: \(String(format: "%.2f", data.medianTemp))"

    }

}

// MARK: Setup UI
extension WeatherDetailsCell{
    
    private func configureUI(){
        
        cityNameLabel.text = "Islamabad, Pakistan"
        windAvgLabel.text = "12.3"
        windMedianLabel.text = "14.2"
        tempAvgLabel.text = "25.3"
        tempMedianLabel.text = "28.1"
        
    }
    
    private func layoutUI(){
       
        let views = [cityNameLabel, windAvgLabel, windMedianLabel, tempAvgLabel, tempMedianLabel]
        
        for item in views{
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
        
            cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            windAvgLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
            windAvgLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            windAvgLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            windMedianLabel.topAnchor.constraint(equalTo: windAvgLabel.bottomAnchor, constant: 8),
            windMedianLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            windMedianLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            tempAvgLabel.topAnchor.constraint(equalTo: windMedianLabel.bottomAnchor, constant: 8),
            tempAvgLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tempAvgLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            tempMedianLabel.topAnchor.constraint(equalTo: tempAvgLabel.bottomAnchor, constant: 8),
            tempMedianLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tempMedianLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tempMedianLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        
        ])
        
    }
    
}
