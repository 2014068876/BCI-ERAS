//
//  PatientHelpTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 01/10/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit
import XCDYouTubeKit

class PatientHelpTableViewController: UITableViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var videoIdentifier = "dQw4w9WgXcQ"
        
        switch indexPath.row {
        case 0:
            videoIdentifier = "rd-n206HPHQ"
        case 1:
            videoIdentifier = "mdi5KyOUw6o"
        case 2:
            videoIdentifier = "2-9wlWHBsLk"
        case 3:
            videoIdentifier = "y-aZ1TYa_xI"
        case 4:
            videoIdentifier = "YcnAHFrDyAQ"
        case 5:
            videoIdentifier = "Oj7cFipHnvQ"
        default: break
        }
        
        let videoPlayer = XCDYouTubeVideoPlayerViewController(videoIdentifier: videoIdentifier)
        presentMoviePlayerViewControllerAnimated(videoPlayer)
    }

}
