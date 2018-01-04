//
//  DoctorHelpTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 28/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit
import XCDYouTubeKit


class DoctorHelpTableViewController: UITableViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var videoIdentifier = "dQw4w9WgXcQ"
        
        switch indexPath.row {
        case 0:
            videoIdentifier = "AZbXxVeARtM"
        case 1:
            videoIdentifier = "R5hBuaZ2An0"
        case 2:
            videoIdentifier = "Yh_etaJfSuc"
        case 3:
            videoIdentifier = "Ikhn4fNvgc4"
        case 4:
            videoIdentifier = "o_2sorxeit8"
        case 5:
            videoIdentifier = "L_aVOGZynxY"
        default: break
        }
        
        let videoPlayer = XCDYouTubeVideoPlayerViewController(videoIdentifier: videoIdentifier)
        presentMoviePlayerViewControllerAnimated(videoPlayer)
    }


}
