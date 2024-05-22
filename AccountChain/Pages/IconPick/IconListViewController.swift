import UIKit

typealias IconListViewControllerCallback = (_ data: IconCellModel?) -> Void

class IconListViewController: UIViewController {
    
    
    var tableView = UITableView()
    var closeButton = UIButton()
    var infoLabel = UILabel()
    var viewModel: IconListViewModel = IconListViewModel()
    private var completion: IconListViewControllerCallback!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        prepareView()
        tableView.reloadData()
    }
        
    init(completion: @escaping IconListViewControllerCallback) {
        self.completion = completion
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareView() {
        view.backgroundColor = .white
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(10)
        }
        infoLabel.text = "Choose an icon"
        infoLabel.textColor = .systemBlue
        infoLabel.font = UIFont.customFont(font: .helvetica, type: .medium, size: 22)
        
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        closeButton.addBorder(width: 1, color: .systemBlue)
        closeButton.setImage(UIImage(named: "close_icon"), for: .normal)
        closeButton.tintColor = .systemBlue
      
        if let originalImage = UIImage(named: "close_icon") {
            let newSize = CGSize(width: 16, height: 16)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            originalImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let resizedImage = resizedImage {
                let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
                closeButton.setImage(tintedImage, for: .normal)
                closeButton.tintColor = UIColor.systemBlue
            }
        }
        
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        closeButton.layer.cornerRadius = 20
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func closeAction() {
        self.completion(IconCellModel(image: "default", iconName: "Default", domain: ""))
        self.dismiss(animated: true)
    }
}


extension IconListViewController: UITableViewDelegate, UITableViewDataSource {
    func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        registerCell()
    }
    
    func registerCell() {
        self.tableView.register(IconCell.self, forCellReuseIdentifier: IconCell.reuseIdentifier)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseIdentifier, for: indexPath) as! IconCell
        cell.selectionStyle = .none
        let item = viewModel.icons[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let icon = self.viewModel.icons[indexPath.row]
        self.completion(icon)
        self.dismiss(animated: true)
    }
}

class IconCell: UITableViewCell {
    
    var topView = UIView()
    var iconImageView = UIImageView()
    var iconNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configView()
        self.topView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configView() {
        
        contentView.backgroundColor = .clear
        
        topView.addBorder(width: 1, color: .systemGray4)
        topView.layer.cornerRadius = 5
        
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(52)
        }
        
        topView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        iconImageView.contentMode = .scaleAspectFit
        
        
        topView.addSubview(iconNameLabel)
        iconNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func configure(viewModel: IconCellModel) {
        self.iconImageView.image = UIImage(named: "\(viewModel.image)")
        self.iconNameLabel.text = viewModel.iconName
    }
}


struct IconCellModel: Codable {
    var image: String
    var iconName: String
    var domain: String
}
