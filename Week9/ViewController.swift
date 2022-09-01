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
//    var list = Person(page: 0, totalPages: 0, totalResults: 0, results: [])
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let example = User("고래밥")
        example.bind { name in
            print("이름이 \(name)으로 바뀌었습니다.")
        }
        example.value = "칙촉"
        
        
        let sample = User([1, 2, 3, 4, 5])
        sample.bind { value in
            print(value)
        }
        sample.value = [6, 7, 8, 9]
        
        
        
        
//        let user = User(name: "고래밥")
//
//        user.nameChanged {
//            print("🥳 nameChanged")
//        }
//
////        user.nameChanged { print("🍪 nameChanged") }
//        user.name = "칙촉"
//
////        user.nameChanged { print("👋🏻 nameChanged") }
//        user.name = "안뇽"
        
        
        
        
        
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2)  // 7
        
        number1 = 3  // 여기에서 3 - 3 은 0이라고 프린트되지 않음
        number2 = 1
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { a in
            print("Observable", number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 200
        number3.value = 50
        
        

        
//        LottoAPIManager.requestLotto(drwNo: 1011)
//        LottoAPIManager.requestLotto(drwNo: 1011) { lotto, error in
//            guard let lotto = lotto else { return }
//
////            DispatchQueue.main.async {  // 네트워크 통신을 하는 횟수만큼 이 코드가 늘어난다 -> 네트워크 통신 함수 안에 메인 쓰레드 넣기로 해결
////                self.lottoLabel.text = lotto.drwNoDate
////            }
//
//            self.lottoLabel.text = lotto.drwNoDate
//        }
        
        
//        PersonAPIManager.requestPerson(query: "Ryan") { person, error in
//            guard let person = person else {
//                return
//            }
//
//            dump(person)
////            self.list = person.results.map { $0.name }
//            self.list = person
//            dump(self.list)
//
//            self.tableView.reloadData()
//        }
        
        viewModel.fetchPerson(query: "Ryan")
        
        viewModel.list.bind { person in
//            print("ViewController bind")
//            self.viewModel.list.value = person
            self.tableView.reloadData()
        }
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.results.count
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.largeContentTitle = "???"
        
//        let data = list.results[indexPath.row]
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
    
        
        return cell
    }
}
