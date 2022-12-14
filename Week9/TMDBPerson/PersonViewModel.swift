//
//  PersonViewModel.swift
//  Week9
//
//  Created by SC on 2022/08/31.
//

import Foundation

class PersonViewModel {
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: "Ryan") { person, error in
            guard let person = person else {
                return
            }

//            dump(person)
//            self.list = person.results.map { $0.name }
//            self.list = person
            self.list.value = person
//            dump(self.list)
            
//            self.tableView.reloadData()
        }
    }
    
    var numberOfRowsInSection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
}
