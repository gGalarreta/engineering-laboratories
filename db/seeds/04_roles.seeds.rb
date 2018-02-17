role = Role.create!(name: "administrador", description: "Controla toda la aplicacion")
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Roles"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Usuarios"), create: true, edit: true, view: true, status: true)


