
import UIKit

class ViewController: UIViewController , ContinentManagerDelegate {
    
    
    var c : Country?
    @IBOutlet var continentTableView: UITableView!
    let continentURL = "https://run.mocky.io/v3/574b3feb-c5a5-4392-b867-7ea388200a8d"
    
    var continent = ContinentManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continent.delegate = self
        continentTableView.delegate = self
        continentTableView.dataSource = self
        continent.performRequest(continentURL: continentURL)
    }
    var continentsResult: [String: [Country]]?
    func didUpdateContinent(cont: [String:[Country]])  {
        continentsResult = cont
        DispatchQueue.main.async {
            self.continentTableView.reloadData()
        }
        
    }
    
    
    
}

//MARK: - UITableView Delegate and DataSource

extension ViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tempCount = continentsResult else { return 0 }
        return tempCount.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tempResult: [String: [Country]] = continentsResult else { return 0 }
        let continentNamme: [String] = Array(tempResult.keys)
        return tempResult[continentNamme[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  continentTableView.dequeueReusableCell(withIdentifier: "continentCell", for: indexPath) as! customTableViewCell
        var content = cell.defaultContentConfiguration()
        guard let tempResult = continentsResult else { return cell }
        let continentNamme: [String] = Array(tempResult.keys)
        let countryArray = tempResult[continentNamme[indexPath.section]]!
        let objCountry = countryArray[indexPath.row]
        content.text = objCountry.countryName
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tempResult = continentsResult else { return "" }
        let continentNamme: [String] = Array(tempResult.keys)
        return continentNamme[section]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tempResult = continentsResult
        let continentNamme: [String] = Array(tempResult!.keys)
        let countryArray = tempResult![continentNamme[indexPath.section]]!
        let objCountry = countryArray[indexPath.row]
        c = objCountry
        //text = "Capital : \(objCountry.details.capital) \n Currency : \(objCountry.details.currency)"
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SecondViewController
        //vc.finalDescription = text
        vc.countyrArray = c
    }
}


//add changes comment
