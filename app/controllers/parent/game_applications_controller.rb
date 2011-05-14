class Parent::GameApplicationsController < Parent::BaseController
  inherit_resources

  def show
    @game_application = GameApplication.find(params[:id])
    load_rule_definitions
  end

  def update
    update! do |success, failure|
      failure.html {
        load_rule_definitions
        flash[:error] = 'set rule definition failed'
        render :action => :show
      }
    end
  end

  protected
    def load_rule_definitions
      @rule_definitions = []
      RuleDefinition::PERIODS.each do |period|
        @rule_definitions << @game_application.rule_definitions.find_or_create_by_period_and_parent_id(period, current_parent.id)
      end
    end
end
