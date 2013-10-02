module UnderConstruction
  module UnderConstruction
    class Hooks  < Redmine::Hook::ViewListener
      render_on(:view_layouts_base_html_head, :partial => "hooks/under_construction/html_head")
    end
  end
end