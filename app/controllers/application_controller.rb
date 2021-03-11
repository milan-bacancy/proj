class ApplicationController < ActionController::Base
	before_action :authenticate_user!, except: %i[index]
	
	def after_sign_up_path_for(resources)
		if current_user.role == "user"
			complaints_path
		else
			admins_path
		end
	end

	def after_sign_in_path_for(resources)
		if current_user.role == "user"
			complaints_path
		else
			admins_path
		end
	end
end
