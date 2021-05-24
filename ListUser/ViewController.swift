//
//  ViewController.swift
//  ListUser
//
//  Created by Pipe Carrasco on 22-05-21.
//

import UIKit

class ViewController: UIViewController {
    
    var users = [User]()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        let service = Service(baseUrl: "https://jsonplaceholder.typicode.com")
        service.getAllUsers { [weak self] result in
          switch result {
          case .failure:
            ErrorPresenter.showError(message: "There was an error getting the users", on: self)
          case .success(let users):
            DispatchQueue.main.async { [weak self] in
              guard let self = self else { return }
              self.users = users
              self.tableView.reloadData()
            }
          }
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath) as? CustomTableViewCell else {
                                                    return UITableViewCell()
        }
        let user = users[indexPath.row]
        let textUsername = "name: \(user.name ?? "name"), username: \(user.username ?? "username")"
        cell.detailTextLabel?.text = user.city ?? "city"
        cell.backgroundColor = .systemRed
        cell.configure(text: textUsername)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }


}



class ErrorPresenter {

  static func showError(message: String, on viewController: UIViewController?, dismissAction: ((UIAlertAction) -> Void)? = nil) {
    weak var vc = viewController
    DispatchQueue.main.async {
      let alert = UIAlertController(title: "Error",
                                    message: message,
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: dismissAction))
      vc?.present(alert, animated: true)
    }
  }
}
