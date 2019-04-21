//
//  ViewController.swift
//  DateCalculator
//
//  Created by Dai Tran on 5/2/18.
//  Copyright © 2018 Dai Tran. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class DateDifferenceViewController: BaseViewController, DateDifferenceInputCellDelegate {
    
    var resultData: [(String, String)] = [("Day", "0"), ("Month", "0"), ("Year","0")]
    var inputDates: [Date] = [Date(), Date()]
    
    var bannerView: GADBannerView?
    
    var interstitial: GADInterstitial?
    
    var pressedHomeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: TwoDateInputCell.self), bundle: .main), forCellReuseIdentifier: inputCellId)
        tableView.register(UINib(nibName: String(describing: DateDifferenceResultCell.self), bundle: .main), forCellReuseIdentifier: resultCellId)
        
        if UserDefaults.standard.object(forKey: isLightThemeKey) == nil {
            UserDefaults.standard.set(true, forKey: isLightThemeKey)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLightTheme = UserDefaults.standard.bool(forKey: isLightThemeKey)
        loadTheme(isLightTheme: isLightTheme)
    }
    
//    func updateTableView() {
//        for row in 0..<tableView.numberOfRows(inSection: 1) {
//            let indexPath = IndexPath(row: row, section: 1)
//            let cell = tableView.cellForRow(at: indexPath) as! DateDifferenceOutputCell
//            cell.resultData = resultData[row]
//        }
//    }
    
    func updateShowingDifferenceDate(dateDifferenceResult: DateDifferenceResult) {
        let outputCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DateDifferenceResultCell
        outputCell.dateDifferenceResult = dateDifferenceResult
    }
    
    func calculateAndUpdateView() {
//        resultData = calculateDateDifference(from: inputDates[0], and: inputDates[1])
//        updateTableView()
    }
    
    @objc override func onRefreshAction() {
        let inputDateCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TwoDateInputCell
        inputDateCell.refreshDate()
    }
    
    override func loadTheme(isLightTheme: Bool) {
        self.isLightTheme = isLightTheme
        self.tableView.backgroundColor = isLightTheme ? UIColor.white : UIColor.black
        
        navigationController?.navigationBar.barTintColor = isLightTheme ? UIColor.white : UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: isLightTheme ? UIColor.black : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
        navigationController?.navigationBar.tintColor = isLightTheme ? UIColor.purpleLilac : UIColor.orange
        
        tabBarController?.tabBar.tintColor = isLightTheme ? UIColor.purpleLilac : UIColor.orange
        tabBarController?.tabBar.barTintColor = isLightTheme ? UIColor.white : UIColor.black
        
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = isLightTheme ? UIColor.white : UIColor.black
        
        tableView.reloadData()
    }
}

//MARK: Conform UITableView Protocols
extension DateDifferenceViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: inputCellId, for: indexPath) as! TwoDateInputCell
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: resultCellId, for: indexPath) as! DateDifferenceResultCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 254 : 200
    }
}
