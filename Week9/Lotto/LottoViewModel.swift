//
//  LottoViewModel.swift
//  Week9
//
//  Created by SC on 2022/09/01.
//

import Foundation

class LottoViewModel {
    var number1 = Observable(1)
    var number2 = Observable(2)
    var number3 = Observable(3)
    var number4 = Observable(4)
    var number5 = Observable(5)
    var number6 = Observable(6)
    var number7 = Observable(7)
    var lottoPrize = Observable("당첨금")
    
    func format(for number: Int) -> String {
        let numberFomatter = NumberFormatter()
        numberFomatter.numberStyle = .decimal  // 👻 나머지 어떤 것들인지 살펴 보기
        return numberFomatter.string(for: number)!
    }
    
    func fetchLottoAPI(drwNo: Int) {
        LottoAPIManager.requestLotto(drwNo: drwNo) { lotto, error in
            guard let lotto = lotto else {
                return
            }

            self.number1.value = lotto.drwtNo1
            self.number2.value = lotto.drwtNo2
            self.number3.value = lotto.drwtNo3
            self.number4.value = lotto.drwtNo4
            self.number5.value = lotto.drwtNo5
            self.number6.value = lotto.drwtNo6
            self.number7.value = lotto.bnusNo
            self.lottoPrize.value = self.format(for: lotto.totSellamnt)
        }
    }
}
