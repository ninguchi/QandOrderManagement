//
//  UIExpandableTableView.swift
//  LabelTeste
//
//  Created by Rondinelli Morais on 11/09/15.
//  Copyright (c) 2015 Rondinelli Morais. All rights reserved.
//

import UIKit

class UIExpandableTableView : UITableView, HeaderViewDelegate {
    
    var sectionOpen:[Int] = []
    var menuListBySection:[[MenuModel]?] = []
    // MARK: HeaderViewDelegate
    func headerViewOpen(section: Int) {
        self.sectionOpen.append(section)
        let numberOfRows = menuListBySection[section]?.count
        var indexesPathToInsert:[NSIndexPath] = []
        for var i = 0; i < numberOfRows; i++ {
            indexesPathToInsert.append(NSIndexPath(forRow: i, inSection: section))
        }
        if indexesPathToInsert.count > 0 {
            self.beginUpdates()
            self.insertRowsAtIndexPaths(indexesPathToInsert, withRowAnimation: UITableViewRowAnimation.Fade)
            self.endUpdates()
        }
    }
    
    func headerViewClose(section: Int) {
        let index = sectionOpen.indexOf(section)
        sectionOpen.removeAtIndex(index!)
        let numberOfRows = menuListBySection[section]?.count
        var indexesPathToDelete:[NSIndexPath] = []
        for var i = 0 ; i < numberOfRows; i++ {
            indexesPathToDelete.append(NSIndexPath(forRow: i, inSection: section))
        }
        if indexesPathToDelete.count > 0 {
            self.beginUpdates()
            self.deleteRowsAtIndexPaths(indexesPathToDelete, withRowAnimation: UITableViewRowAnimation.Top)
            self.endUpdates()
        }
    }
}
