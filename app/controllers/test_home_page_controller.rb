class TestHomePageController < ApplicationController
  #before_action :user_only
  def index
    # execute SQL query just for testing
    query = "update users set university='NCSU' where email='a@g'"
    @res1 = ActiveRecord::Base.connection.execute(query)
    query = 'select * from users'
    @resquery = ActiveRecord::Base.connection.execute(query)
  end

  def admin_only
    unless current_user.admin?
      redirect_to home_index_path , :alert => "Access denied."
    end
  end
end
