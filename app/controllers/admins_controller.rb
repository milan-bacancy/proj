class AdminsController < ApplicationController
	def index
		@users = User.with_role(:user)
		@complaints = Complaint.all
	end

	def show
		@complaint = Complaint.find(params[:id])
	end

	def update
		@complaint = Complaint.find(params[:id])
		if @complaint.status == "ongoing"
			@arg = "resolved"
		else
			@arg = "ongoing"
		end
		@complaint.update(status: @arg)
		redirect_to admins_path
	end

	def destroy
		@complaint = Complaint.find(params[:id])
		@complaint.destroy
		redirect_to admins_path
	end
end
