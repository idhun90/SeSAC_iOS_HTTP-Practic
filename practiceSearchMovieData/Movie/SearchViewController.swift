import UIKit

import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var list: [BoxOfficeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        
        let UINib = UINib(nibName: ListTableViewCell.id, bundle: nil)
        searchTableView.register(UINib, forCellReuseIdentifier: ListTableViewCell.id)
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.estimatedRowHeight = 160
        
        requestBoxOffice(text: "20220801")
    }
    
    func requestBoxOffice(text: String) {
        let url = "\(EndPoint.boxOfficeURL)?key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                // 분기 처리, statusCode 범위에 따라 success 허용이 될 수 있다.
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    for movieData in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                        
                        let movieTitle = movieData["movieNm"].stringValue
                        let movieRelease = movieData["openDt"].stringValue
                        let movieRank = movieData["rank"].stringValue
                        let movieAudiAcc = movieData["audiAcc"].stringValue
                        
                        let data = BoxOfficeModel(movieTitle: movieTitle, releaseDate: movieRelease, rank: movieRank, audiAcc: movieAudiAcc)
                        
                        self.list.append(data)
                        self.searchTableView.reloadData()
                    }
                } else {
                    print("\(json["errorMessage"].stringValue)")
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = "영화: \(list[indexPath.row].movieTitle)"
        cell.releaseLabel.text = "출시일: \(list[indexPath.row].releaseDate)"
        cell.rankLabel.text = "순위: \(list[indexPath.row].rank)"
        cell.audiAccLabel.text = "누적 관객 수: \(list[indexPath.row].audiAcc)"
        
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
