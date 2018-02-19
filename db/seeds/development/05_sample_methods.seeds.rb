laboratory = Laboratory.find_by(name: "laboratorio Test A")
SampleMethod.create(name: "prueba de ph", description: "Evaluacion sobre el nivel de acidez en agua", unit_cost: 123, active: true, accreditation: 1, laboratory: laboratory)

laboratory = Laboratory.find_by(name: "laboratorio Test B")
SampleMethod.create(name: "prueba de corrosion", description: "Evaluacion sobre el nivel de corrosion en metales", unit_cost: 123, active: true, accreditation: 1, laboratory: laboratory)
