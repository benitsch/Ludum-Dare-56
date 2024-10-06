extends RichTextLabel


func _ready() -> void:
    buildText()
    self.meta_clicked.connect(_on_credits_label_meta_clicked)
    
func _on_credits_label_meta_clicked(meta: Variant) -> void:
    if meta is String and meta.begins_with('https://'):
        OS.shell_open(meta)

func buildText() -> void:
    self.text = ''
    addUser('Berni', 'Emotional Support', 'zom0')
    addUser('Fin', 'Audio', '', 'https://www.youtube.com/@FIN_Der-Otter')
    addUser('Flocke', 'Mascot')
    addUser('Martin', 'Programming, Level Design', '20goto10')
    addUser('Natascha', 'Animation, Level Design', 'krisss-gonko')
    addUser('Stephie', 'Animation, Art', 'kyunru')
    addUser('Tine', 'Programming, UI', 'mireyu')
    addLine()
    addUrl('https://github.com/benitsch/Ludum-Dare-56', 'Github')
    self.text += ', '
    addUrl('https://ldjam.com/events/ludum-dare/56/$400535', 'Ludum Dare 56')
    addLine()
    addLine()
    addLine('Thank you for playing :)')

func addUrl(url: String, label: String = '') -> void:
    self.text += '[url=' + url + ']' + label + '[/url]'

func addLine(string: String = '') -> void:
    self.text += string + '\n'
    
func addUser(name: String, tags: String, itchUser: String = '', directLink: String = '') -> void:
    if itchUser != '':
        addUrl('https://' + itchUser + '.itch.io', name)
    elif directLink != '':
        addUrl(directLink, name)
    else:
        self.text += name

    addLine(' - ' + tags)
