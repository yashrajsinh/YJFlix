//
//  MoviesViewController.swift
//  YJFlix
//
//  Created by Yashraj on 09/02/26.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tblMoviesList: UITableView!
    let apiService = APIService()
    var shows: [Show] = []

    //Pagging
    var currentPage = 0
    var isLoading = false
    var hasMoreData = true

    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieList()
        setupTable()
    }

    func getMovieList() {
        guard !isLoading, hasMoreData else { return }

        isLoading = true
        apiService.fetchData(page: currentPage) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let newShows):
                    if newShows.isEmpty {
                        self.hasMoreData = false
                        return
                    }
                    self.shows.append(contentsOf: newShows)
                    self.tblMoviesList.reloadData()
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                }
            }
        }
    }

    //MARK: Steup Table
    func setupTable() {
        tblMoviesList.dataSource = self
        tblMoviesList.delegate = self
        tblMoviesList.register(
            UINib(nibName: "MoviesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MovieCell"
        )
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        // When last 3 cells are about to appear
        if indexPath.row == shows.count - 3 {
            getMovieList()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "MovieCell",
                for: indexPath
            ) as! MoviesTableViewCell
        let movieItem = shows[indexPath.row]
        cell.configureCell(with: movieItem)
        return cell
    }
}
