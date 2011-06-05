class Parent::ChildrenController < Parent::BaseController
  inherit_resources

  def game
    @child = current_child
    load_rule_definitions
  end

  def education
    @education_application = EducationApplication.new
  end

  def update
    update! do |success, failure|
      failure.html {
        load_rule_definitions
        flash[:error] = 'set rule definition failed'
        render :action => :game
      }
      success.html {
        redirect_to :back
      }
    end
  end

  protected
    def load_rule_definitions
      @rule_definitions = []
      RuleDefinition::PERIODS.keys.each do |period|
        @rule_definitions << current_child.rule_definitions.find_or_create_by_period_and_client_application_id(period, nil)
      end
    end
end
