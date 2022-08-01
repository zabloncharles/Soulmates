//
//  Task.swift
//  SwiftUI Custom Calender
//
//  Created by Zablon Charles on 11/25/21.
//

import SwiftUI

//task model and sample Tasks..
// array of task

struct DateValuet: Identifiable {
  var id = UUID().uuidString
  var day: Int
  var date: Date

}

struct Task: Identifiable{
   var id = UUID().uuidString
   var title: String
    var description: String
   //var date: Date
    //= Date()
}

//Total task
struct TaskMetaData: Identifiable{
  var id = UUID().uuidString
  var task: [Task]
  var taskDate : Date
}

//sample date for testing...
func getSampleDate (offset: Int)->Date{
  let calendar = Calendar . current
  let date = calendar.date(byAdding : .day, value: offset, to: Date())
  return date ?? Date()
}

//sample tasks
var tasks: [TaskMetaData] = [
    
    TaskMetaData (task: [
        Task(title : "Talk to iJustine", description: "Today is the day you talk to her"),
            Task(title: "iPhone 13 Great Design Change", description: "Today is the day you talk to her"),
            Task(title: "Nothing Much Workout !!!", description: "Today is the day you talk to her")
    ], taskDate : getSampleDate(offset : -1)),
    
         TaskMetaData (task: [
            Task(title : "Talk to Jenna Ezarik", description: "Today is the day you talk to her")
    ], taskDate : getSampleDate(offset : -2)),
    
     TaskMetaData (task: [
             Task(title: "Meeting with Tim Cook", description: "Today is the day you talk to her")
     ], taskDate: getSampleDate(offset : -3)),
     
     TaskMetaData (task: [
             Task(title: "Next Version of SwiftUI", description: "Today is the day you talk to her")
     ], taskDate: getSampleDate(offset : -4)),
     
     TaskMetaData (task:[
             Task(title: "Nothing Much Workout !!!", description: "Today is the day you talk to her")
     ], taskDate : getSampleDate(offset: -5)),
     
     TaskMetaData (task: [
             Task(title: "iPhone 13 Great Design Change", description: "Today is the day you talk to her")
     ], taskDate : getSampleDate(offset : -6)),
     
     TaskMetaData (task: [
             Task (title: "Kavsoft App Updates . . . . ", description: "Today is the day you talk to her")
     ], taskDate: getSampleDate(offset : 0)),
    ]
