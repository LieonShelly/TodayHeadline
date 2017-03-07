//
//  FollowViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/3/7.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import CoreData

class FollowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let studentClassName: String = "Student"
        let courseClassName: String = "Course"
        guard  let student: Student = NSEntityDescription.insertNewObject(forEntityName: studentClassName, into: DataBaseController.getContext()) as? Student else { return }
        student.age = 12
        student.firstName = "Jhon"
        student.lastName = "Smith"
        guard let course: Course = NSEntityDescription.insertNewObject(forEntityName: courseClassName, into: DataBaseController.getContext()) as? Course else { return }
        course.courseName = "Computer Science 402"
        
        DataBaseController.saveContext()
        
        let fetchrequset: NSFetchRequest<Student> = Student.fetchRequest()
         guard let searchResults = try? DataBaseController.getContext().fetch(fetchrequset) else { return  }
        for result in searchResults {
            print("\(result.firstName!) \(result.lastName!) is \(result.age) years old.")
        }
    }

}
