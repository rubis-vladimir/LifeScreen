//
//  LifeEventListViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import UIKit
import RealmSwift

/// Протокол управления View-слоем в модуле LifeEventList
protocol LifeEventListViewable: AnyObject {
    
}

/// Контроллер представления жизненных событий
class LifeEventListViewController: UITableViewController {

    var presenter: LifeEventListPresentation?
    
    let localeStorageManager: LocaleStorageManagement = LocaleStorageManager()
    let urls: [String] = ["sdfhjksdhfk.ru", "jsdfknavfdv.com", "sjkdfkjsnfj.ya"]
    
    let eventsData: [String: String] = ["Новый год 2022": "Было очень весело", "Выезд с палатками": "Покутили", "Спортакиада": "Снова.. первые!!"]
    let dates: [String] = ["11-20-2022", "07-03-2022", "05-25-2022"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        let user = UserModel(name: "Петр")
        user.email = "petyaTop@mail.ru"
        user._id = ObjectId("507f191e810c19729de860ea")

        zip(eventsData, dates).forEach { event, date in
            
            let event = EventModel(title: event.key, specification: event.value)
            event.date = DateConvertService.convertStrToDate(date) ?? Date()
            
            urls.forEach {
                let image = Image(urlString: $0)
                event.images.append(image)
            }
            user.events.append(event)
        }
        
//        localeStorageManager.saveObject(user)
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let key = ObjectId("507f191e810c19729de860ea")
        
        guard let userModel = localeStorageManager.fetchObject(UserModel.self, key: key) else {
            print("Модель не получена")
            return }
//        print(userModel)
        
        let events = userModel.events.where { $0.title == "Выезд с палатками"}
        
        print(events)
        print(events.count)
        print("_____________________")
        
//        localeStorageManager.updateObject(userModel) {
//            userModel.events[0].title = ".!."
//            userModel.events.removeLast()
//        }
//
//        print("_____________________")
//
//        guard let userModel = localeStorageManager.fetchObject(UserModel.self, key: key) else {
//            print("Модель не получена")
//            return }
//        print(userModel)
//
//        localeStorageManager.deleteObject(userModel)
//        print("Объект удален")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(7)) {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            print(path.path)
        }
        
                                                                                                                
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.backgroundColor = .brown

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.readyForLoadAndRoute(to: .detailInfo)
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - LifeEventListViewable
extension LifeEventListViewController: LifeEventListViewable {
    
}

