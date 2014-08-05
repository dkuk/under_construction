class UcRoute
  def self.routes
    if @routes.nil?
      @routes = self.get_routes
    end
    @routes
  end

  def self.get_routes
    Rails.application.reload_routes! if Rails.env.development?
    routes = Rails.application.routes.routes.group_by{|route| route.defaults[:controller]}.collect do |controller, values|
      actions = []
      values.each do |v|
        actions << v.defaults[:action]
      end
      actions = actions.reject{|action| action.nil? || action.empty?}.uniq
      {controller: controller.to_s, actions: actions}
    end
    routes
  end

  def self.controllers
    if @controllers.nil?
      @controllers = self.routes{|route| route[:controller]}.sort
    end
  end
end