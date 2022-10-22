//
//  ViewController.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 21/10/22.
//

import UIKit

import SDWebImage

class SaveMangasViewController: UIViewController {
    
    let mangaTableView = UITableView(frame: .zero, style: .grouped) // view
    
    var mangaFav: [MangasData] = [] //vem do delegate
    var mangaCoreData: [PersonalManga] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mangaTableView)
        mangaCoreData = CoreDataStack.shared.fetchMangaEntity()
        print(mangaCoreData)
        
        //retorna um array de PersonalManga
        
        mangaTableView.reloadData()
        
        mangaTableView.translatesAutoresizingMaskIntoConstraints = false
        mangaTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        mangaTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mangaTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mangaTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mangaTableView.dataSource = self
        mangaTableView.delegate = self //herda do delegate
        
        mangaTableView.register(MangaTableViewCell.self, forCellReuseIdentifier: "mangaCell")
        setUpNavigation()
        
    }
    
    //view
    func setUpNavigation() {
        navigationItem.title = "Meus Mangás"
        navigationController?.navigationBar.prefersLargeTitles = true
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        coloredAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        self.navigationController?.navigationBar.standardAppearance = coloredAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = coloredAppearance
        self.navigationController?.navigationBar.compactAppearance = coloredAppearance
    }
}

extension SaveMangasViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangaFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentManga = mangaFav[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath) as! MangaTableViewCell
        cell.configure(with: currentManga)
        return cell
    }
}

extension SaveMangasViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
