import UIKit
import SwiftData

class RecipesTableViewController: UIViewController {
    private var recipes = [RecipeModel]()
    private var emptyView = EmptyListView()

    let descriptor = FetchDescriptor<RecipeModel>()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.selectionFollowsFocus = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: String(describing: RecipeCell.self))
        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        checkEmptyList()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func createRecipe() {
        let formController = FormViewController()
        self.navigationController?.pushViewController(formController, animated: true)
    }

    private func setupNavigationBar() {
        title = "Receitas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createRecipe))
    }

    private func checkEmptyList() {
        if recipes.count == 0 {
            view = EmptyListView()
        } else {
            view = tableView
        }
    }

    private func fetchData() {
        DataBaseHelper.shared.fetchTasks { data, error in
            if let error {
                print(error)
            }
            if let data {
                self.recipes = data
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension RecipesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipes.count == 0 {
            tableView.backgroundView = EmptyListView()
        } else {
            tableView.backgroundView = nil
        }
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeCell.self), for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }

        let recipe = recipes[indexPath.row]
        cell.prepareCell(recipe: recipe)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RecipesTableViewController: UITableViewDelegate {
    private func setupCellLayout(indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .gray

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            cell?.selectionStyle = .none
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setupCellLayout(indexPath: indexPath)
        let recipes = recipes[indexPath.row]
        let recipeViewController = DetailViewController(recipe: recipes)
        recipeViewController.recipe = recipes
        self.navigationController?.show(recipeViewController, sender: recipes)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataBaseHelper.shared.deleteRecipe(recipeModel: recipes[indexPath.row])
        fetchData()
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height
        return height * 0.15
    }
}
