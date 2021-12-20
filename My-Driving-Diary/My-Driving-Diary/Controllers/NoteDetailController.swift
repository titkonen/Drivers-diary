import UIKit

protocol NoteDelegate {
    func saveNewNote(
        title: String,
        date: Date,
        text: String,
        jobtitle: String,
        email: String,
        phoneNumber: String,
        status: String
    )
}

class NoteDetailController: UIViewController {
    
    // MARK: PROPERTIES
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY hh:mm"
        return dateFormatter
    }()
    
    var noteData: Note! {
        didSet {
            dateLabel.text = dateFormatter.string(from: noteData.date ?? Date())
            textView.text = noteData.title
            clientName.text = noteData.text ///Preview
            jobtitle.text = noteData.jobtitle
            email.text = noteData.email
            phoneNumber.text = noteData.phoneNumber
            status.text = noteData.status
            
        }
    }
    
    var delegate: NoteDelegate?
    
    fileprivate var textView: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Company name"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    fileprivate var clientName: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Contact name"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.text = dateFormatter.string(from: Date())
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var jobtitle: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Jobtitle"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    fileprivate var email: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Email address"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    fileprivate var phoneNumber: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Phone number"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    fileprivate var status: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Status of client contact"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.noteData == nil {
            delegate?.saveNewNote(
                title: textView.text,
                date: Date(),
                text: clientName.text,
                jobtitle: jobtitle.text,
                email: email.text,
                phoneNumber: phoneNumber.text,
                status: status.text
            )
        } else {
            /// updates title text
            guard let newText = self.textView.text else {
                return
            }
            /// Updates Description text
            guard let newPreview = self.clientName.text else {
                return
            }
            
            /// Updates Jobtitle text
            guard let newJobtitle = self.jobtitle.text else {
                return
            }

            /// Updates email text
            guard let newEmail = self.email.text else {
                return
            }
            
            /// Updates phoneNumber text
            guard let newPhoneNumber = self.phoneNumber.text else {
                return
            }
            
            /// Updates phoneNumber text
            guard let newStatus = self.status.text else {
                return
            }
            
            CoreDataManager.shared.saveUpdatedNote(
                note: self.noteData,
                newText: newText,
                newPreview: newPreview,
                newJobtitle: newJobtitle,
                newEmail: newEmail,
                newPhoneNumber: newPhoneNumber,
                newStatus: newStatus
            )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let items: [UIBarButtonItem] = [
////            UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
//        ]
//
//        self.toolbarItems = items
//
//        let topItems: [UIBarButtonItem] = [
//            UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
//            UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
//        ]
//
//        self.navigationItem.setRightBarButtonItems(topItems, animated: false)
    }
    
    // MARK: FUNCTIONS
    fileprivate func setupUI() {
        view.addSubview(dateLabel)
        view.addSubview(textView)
        view.addSubview(clientName)
        view.addSubview(jobtitle)
        view.addSubview(email)
        view.addSubview(phoneNumber)
        view.addSubview(status)
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -720).isActive = true
        
        clientName.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        clientName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        clientName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        clientName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -660).isActive = true
    
        jobtitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        jobtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        jobtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        jobtitle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -610).isActive = true
  
        email.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        email.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -560).isActive = true
  
        phoneNumber.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        phoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        phoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        phoneNumber.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -510).isActive = true
  
        status.topAnchor.constraint(equalTo: view.topAnchor, constant: 420).isActive = true
        status.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        status.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        status.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -310).isActive = true
  
    }
    
    /// Text field testing

    
}
