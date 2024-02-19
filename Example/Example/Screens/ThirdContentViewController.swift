//
//  ThirdContentViewController.swift
//  Example
//
//  Created by Oleg Krasnov on 08/11/2023.
//

import Navidux
import UIKit

final class ThirdContentViewController: ViewController {
    
    private let dataSource: [ThirdContentCellModel] = [
        .init(image: .actions, title: "Actions"),
        .init(image: .add, title: "Add"),
        .init(image: .checkmark, title: "Checkmark"),
        .init(image: .remove, title: "Remove"),
        .init(image: .strokedCheckmark, title: "StrokedCheckmark"),
        
        .init(image: .actions, title: "Actions"),
        .init(image: .add, title: "Add"),
        .init(image: .checkmark, title: "Checkmark"),
        .init(image: .remove, title: "Remove"),
        .init(image: .strokedCheckmark, title: "StrokedCheckmark"),
        
        .init(image: .actions, title: "Actions"),
        .init(image: .add, title: "Add"),
        .init(image: .checkmark, title: "Checkmark"),
        .init(image: .remove, title: "Remove"),
        .init(image: .strokedCheckmark, title: "StrokedCheckmark")
    ]
    
    private lazy var pullBar = PullBar()
    
    private lazy var tableView: BSTableView = {
        let tableView = BSTableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(
            ThirdContentTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: ThirdContentTableViewCell.self
            )
        )
        return tableView
    }()
        
    init() {
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [pullBar ,tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            pullBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pullBar.topAnchor.constraint(equalTo: view.topAnchor),
            pullBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pullBar.heightAnchor.constraint(equalToConstant: 36),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: pullBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension ThirdContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ThirdContentTableViewCell.self), for: indexPath) as? ThirdContentTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configureWith(
            image: dataSource[indexPath.row].image,
            title: dataSource[indexPath.row].title
        )
        return cell
    }
}

extension ThirdContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}

struct ThirdContent: Module {
    func assembly(using coordinator: Coordinator) -> UIViewController {
        return ThirdContentViewController()
    }
}

extension Module where Self == ThirdContent {
    static var third: Self {
        return .init()
    }
}
