module ApplicationHelper

  def change_status
    self.update_attributes(active: !self.active)
  end

  def tooltip_status
    self.active ? "Desactivar" : "Activar"
  end
end
