import UIKit
import RealmSwift

class RecipesTableViewController: UIViewController {
    private var recipes: Results<RecipeModel>?
    private var emptyView = EmptyListView()

    let realm = try! Realm()

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
        loadItems()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    private func loadItems() {
        let realmData = realm.objects(RecipeModel.self)
        recipes = realmData
        tableView.reloadData()
    }

    func removeDataFromRealm(indexPath: IndexPath) {
        do {
            let realm = try Realm()
            let selectedRecipe = realm.objects(RecipeModel.self)

            try realm.write {
                realm.delete(selectedRecipe[indexPath.row])
            }
        } catch let error as NSError {
            print("Error removing data from Realm: \(error.localizedDescription)")
        }
    }
}

// MARK: - UITableViewDataSource

extension RecipesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipes?.count == 0 {
            tableView.backgroundView = EmptyListView()
        } else {
            tableView.backgroundView = nil
        }
        return recipes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeCell.self), for: indexPath) as? RecipeCell,
              let recipe = recipes?[indexPath.row] else { return UITableViewCell() }
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
        if let recipes = recipes?[indexPath.row] {
            let recipeViewController = DetailViewController(recipe: recipes)
            recipeViewController.recipe = recipes
            self.navigationController?.show(recipeViewController, sender: recipes)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        removeDataFromRealm(indexPath: indexPath)
//        recipes.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height
        return height * 0.15
    }
}
