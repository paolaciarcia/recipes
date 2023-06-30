

import UIKit

class RecipesTableViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private var recipe = [Recipe(name: "frango", portions: 3, timePrepare: "34 min", ingredients: "franog", instructions: "jvbknm.l", isButtonEnable: true)]

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: String(describing: RecipeCell.self))
        return tableView
    }()

    private var emptyView = EmptyListView()

    override func loadView() {
        checkEmptyList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Receitas"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createRecipe))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateRecipeList(notification:)), name: .RecipeSaved, object: nil)
        tableView.reloadData()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func updateRecipeList(notification: Notification) {
        guard let recipes = notification.object as? Recipe else {
            return
        }
        recipe.append(recipes)
        tableView.reloadData()
    }

    @objc func createRecipe() {
        let viewController = FormViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    private func checkEmptyList() {
        if recipe.isEmpty {
            view = emptyView
        } else {
            view = tableView
        }
    }
}
    
    // MARK: - Table view data source

extension RecipesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeCell.self), for: indexPath) as? RecipeCell else { return UITableViewCell() }

        let recipe = recipe[indexPath.row]
        cell.prepareCell(recipe: recipe)
        return cell
    }
}

        // MARK: - Table view Delegate

    extension RecipesTableViewController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let recipes = recipe[indexPath.row]
            let recipeViewController = DetailViewController(recipe: recipes)

            recipeViewController.recipe = recipes
            navigationController?.show(recipeViewController, sender: recipes)
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            recipe.remove(at: indexPath.row)

            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }

//#Preview("RecipesTableViewController") {
//    let viewController = RecipesTableViewController()
//    return viewController
//}
