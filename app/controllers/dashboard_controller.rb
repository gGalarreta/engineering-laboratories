class DashboardController < ApplicationController

  def home
    @employees = User.belongs_work_environment(current_user)
    @services = Service.belongs_work_environment current_user
    @data = {
      labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "JUlio"],
      datasets: [
        {
            label: "Empleados",
            #backgroundColor: "rgb(255, 191, 128)",
            borderColor: "rgb(255, 191, 128)",
            data: User.get_chart_values_through_months("january", "july")
        },
        {
            label: "Servicios",
            #backgroundColor: "rgb(255, 112, 77)",
            borderColor: "rgb(255, 112, 77)",
            data: Service.get_chart_values_through_months("january", "july")
        }      
      ]
    }
    @options = {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
  end

end
