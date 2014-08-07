class UcRoute
  def self.routes
    if @routes.nil?
      @routes = self.get_routes
    end
    @routes
  end

  def self.get_routes
    Rails.application.reload_routes! if Rails.env.development?
    routes_hash = {}
    routes = Rails.application.routes.routes.group_by{ |route| route.defaults[:controller] }.collect do |controller, values|
      actions = []
      values.each do |v|
        actions << v.defaults[:action]
      end
      actions = actions.reject{|action| action.nil? || action.empty?}.push("all").uniq.sort
      if controller.to_s.length > 0
        routes_hash.store(controller.to_s, actions)
      end
    end
    routes_hash
  end

  def self.controllers
    if @controllers.nil?
      @controllers = self.routes.keys.reject{ |controller| controller == "account" }.sort
    end
    @controllers
  end

  def self.actions(controller = nil)
    if controller.nil?
      actions = self.routes.map{|k, v| v}.flatten.sort
    end
    if self.routes.key?(controller)
      actions = self.routes[controller]
    else
      []
    end
  end
end