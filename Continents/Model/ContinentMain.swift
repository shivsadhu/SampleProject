//
//  ContinentMain.swift
//  Continents
//
//  Created by Shivani Ramanathan on 1/5/23.
//

import Foundation

/*struct Continent {
 
 var Country = [ContinentInit(continents:"Asia",country:["India","Japan"],descriptions: ["Capital of India is New Delhi","Capital of Japan is Tokyo"]),ContinentInit(continents:"Africa",country:["Nigeria","Kenya"],descriptions:["Capital of Nigeria is Abuja","Capital of Kenya is Niarobi"]),ContinentInit(continents:"North America",country:["United States","Canada"],descriptions: ["Capital of United States is Washington D.C","Capital of Canada is Ottawa"]),ContinentInit(continents:"South America",country:["Brazil","Argentina"],descriptions: ["Capital of Brazil is Brasília","Capital of Argentina is Buenos Aires"]),ContinentInit(continents:"Antarctica",country:["Antartctica"],descriptions: ["There is no capital as such since Antarctica is not a country, but rather a collection of territorial claims from various other countries"]),ContinentInit(continents:"Europe",country:["Germany","United Kingdom"],descriptions: ["Capital of Germany is Berlin","Capital of United Kingdom is London"]),ContinentInit(continents:"Australia",country:["Australia","New Zealand"],descriptions: ["Capital of Australia is Canberra","Capital of New Zealand is wellington"])]
 
 }*/
protocol ContinentManagerDelegate {
    func didUpdateContinent(cont:[String:[Country]])
}

struct ContinentManager {
    
    let continentURL = "https://run.mocky.io/v3/574b3feb-c5a5-4392-b867-7ea388200a8d"
    var delegate: ContinentManagerDelegate?
    func performRequest(continentURL: String) {
        if let url = URL(string: continentURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let conti = self.parseJSON(continentData: safeData){
                        self.delegate?.didUpdateContinent(cont:conti)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    func parseJSON(continentData: Data) -> [String : [Country]]? {
        let decoder = JSONDecoder()
        do {
            let  decodedData = try decoder.decode(Result.self, from: continentData)
            var continentName1 = [String : [Country]]()
            
            for objContinent in decodedData.continents {
                continentName1[objContinent.continentName] = objContinent.country
                
            }
            return continentName1
            
            
            // return decodedData
            //
            //
            //       //No.Of Rows
            //            var countryCount = 0
            //            for objContinent in decodedData.continents {
            //                for objContinent in objContinent.country {
            //               countryCount += 1
            //                    //let rowCount = countryCount
            //                }
            //            }
            //            //No.Of.Sections
            //            var continentCount = 0
            //            for objContinent in decodedData.continents {
            //                continentCount += 1
            //                //let SectionCount = continentCount
            //            }
            //            //ContinentName
            //
            //            var sectionName = [String]()
            //            for objContinent in decodedData.continents {
            //              sectionName.append(objContinent.continentName)
            //              }
            //            //CountryName
            //            var rowName = [String]()
            //            for objContinent in decodedData.continents {
            //                for objContinent in objContinent.country {
            //                    rowName.append(objContinent.countryName)
            //                }
            //            }
            //          //Details
            //         /*   let description : [String]
            //            for objContinent in decodedData.continents {
            //                for objContinent in objContinent.country {
            //                  description = [objContinent.details]
            //                }
            //            }*/
            //            let cont =  ContinentModel(dict: continentName1)
            //        return cont
            
        }
        catch {
            print(error)
            
        }
        return nil
    }
}

