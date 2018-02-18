role = Role.create!(name: "administrador", description: "Controla toda la aplicacion")
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Roles"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Usuarios"), create: true, edit: true, view: true, status: true)

role = Role.create!(name: "cliente", description: "Controla lo que debe ver el cliente")
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Laboratorios"), create: true, edit: true, view: true, status: true)

laboratory = Laboratory.find_by(name: "laboratorio Test A")
role = Role.create!(name: "empleado", description: "trabajador de laboratorio A", laboratory: laboratory)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Usuarios"), create: true, edit: true, view: true, status: true)
