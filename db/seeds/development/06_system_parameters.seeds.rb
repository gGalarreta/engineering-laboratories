laboratory = Laboratory.find_by(name: "laboratorio Test A")
SystemParameter.create(feature: 0, description: "Laboratorio Test A" ,laboratory: laboratory )
SystemParameter.create(feature: 1, description: "Bienvenido" ,laboratory: laboratory )
SystemParameter.create(feature: 2, description: "Terminos y condiciones" ,laboratory: laboratory )

laboratory = Laboratory.find_by(name: "laboratorio Test B")
SystemParameter.create(feature: 0, description: "Laboratorio Test B" ,laboratory: laboratory )
SystemParameter.create(feature: 1, description: "Bienvenido" ,laboratory: laboratory )
SystemParameter.create(feature: 2, description: "Terminos y condiciones" ,laboratory: laboratory )