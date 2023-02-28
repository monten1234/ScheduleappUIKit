//
//  ScheduleCell.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/23.
//

import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    
    var dateMonth: String = ""
    var dateDay: String = ""
    
    func setSchedule(scheduleInfo: ScheduleInfo) {
        getDate(date: scheduleInfo.date)
        dateLabel.text = "\(self.dateMonth)月\(self.dateDay)"
        titleLabel.text = scheduleInfo.title ?? ""
        memoLabel.text = scheduleInfo.memo ?? ""
//        print(dateLabel.text ?? "a")
//        print(titleLabel.text ?? "b")
//        print(memoLabel.text ?? "c")
    }
    
    func getDate(date: Date) {
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        self.dateMonth = String(month)
        self.dateDay = String(day)
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
