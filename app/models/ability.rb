class Ability
  include CanCan::Ability

  def initialize(staff)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    alias_action :read,:create,:update, :to => :modify
    alias_action :update_password,:edit_password, :to => :pass_modify
    staff ||=Staff.new
    if staff.is? :admin
      can :manage, :all
    end
    if staff.is? :user
      can [:create,:read,:update,:change], [Task,Workobject,Staffobjectjournal,Post,Upload,TaskDelegate,TaskWoStaff]
      can [:read,:pass_modify], Staff
    end
    if staff.is? :finansist
      can :manage, Finance
    end
    if staff.is? :guest
      can :read, [Post,Workobject]
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
