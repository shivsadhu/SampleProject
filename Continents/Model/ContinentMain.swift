//
//  ContinentMain.swift
//  Continents
//
//  Created by Shivani Ramanathan on 1/5/23.
//

import Foundation
protocol ContinentManagerDelegate {
    func didUpdateContinent(cont:[String:[Country]])
}

struct ContinentManager {
    
    let continentURL = "https://run.mocky.io/v3/574b3feb-c5a5-4392-b867-7ea388200a8d"
    
    let key = "SavedData"
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
            // User default
             let encoder = JSONEncoder()
             let encoded = try? encoder.encode(decodedData)
             let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
            if let SavedData = defaults.object(forKey: key) as? Data {
            let decodedsavedData = JSONDecoder()
            let finalData = try? decodedsavedData.decode(Result.self, from: SavedData)
                print(finalData?.continents as Any)
        }
            for objContinent in decodedData.continents {
                continentName1[objContinent.continentName] = objContinent.country
                
            }
            return continentName1
        }
        catch {
            print(error)
            
        }
        return nil
    }
}

