//
//  ViewController.swift
//  Week9
//
//  Created by SC on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lottoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
//    var list: [String] = []
//    var list: Person?
    var list = Person(page: 0, totalPages: 0, totalResults: 0, results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        LottoAPIManager.requestLotto(drwNo: 1011)
        LottoAPIManager.requestLotto(drwNo: 1011) { lotto, error in
            guard let lotto = lotto else { return }
            
//            DispatchQueue.main.async {  // 네트워크 통신을 하는 횟수만큼 이 코드가 늘어난다 -> 네트워크 통신 함수 안에 메인 쓰레드 넣기로 해결
//                self.lottoLabel.text = lotto.drwNoDate
//            }
            
            self.lottoLabel.text = lotto.drwNoDate
        }
        
        
        PersonAPIManager.requestPerson(query: "Ryan") { person, error in
            guard let person = person else {
                return
            }

            dump(person)
//            self.list = person.results.map { $0.name }
            self.list = person
            dump(self.list)
            self.tableView.reloadData()
        }
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.largeContentTitle = "???"
        cell.textLabel?.text = list.results[indexPath.row].name
        cell.detailTextLabel?.text = list.results[indexPath.row].knownForDepartment
        
        return cell
    }
}
