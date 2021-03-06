role = Role.create!(name: "administrador", description: "Controla toda la aplicacion")
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Roles"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Laboratorios"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Empleados"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Clientes"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Metodos de Ensayo"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Categoria de muestra"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Parametros del sistema"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Auditoria"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Inventario"), create: true, edit: true, view: true, status: true)

role = Role.create!(name: "cliente", description: "Controla lo que debe ver el cliente")
role.menu_actions.create!(menu: Menu.find_by(controller_name: "client_services"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(controller_name: "client_quotations"), create: true, edit: true, view: true, status: true)


laboratory = Laboratory.find_by(name: "laboratorio Test A")
role = Role.create!(name: "empleado", description: "trabajador de laboratorio A", laboratory: laboratory)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Parametros del sistema"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Metodos de Ensayo"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Categoria de muestra"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Empleados"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(controller_name: "employee_services"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(controller_name: "employee_quotations"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(navigation_name: "Inventario"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(controller_name: "supervisor_custody_orders"), create: true, edit: true, view: true, status: true)
role.menu_actions.create!(menu: Menu.find_by(controller_name: "employee_custody_orders"), create: true, edit: true, view: true, status: true)

laboratory = Laboratory.find_by(name: "laboratorio Test A")
role = Role.create!(name: "empleado_A", description: "trabajador de laboratorio A", laboratory: laboratory)
role.menu_actions.create!(menu: Menu.find_by(controller_name: "employee_custody_orders"), create: true, edit: true, view: true, status: true)
