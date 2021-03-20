class AdminsController < ApplicationController
	def index
		@users = User.where(role: "user")
		@complaints = Complaint.all
	end

	def show
		# @user = User.find(params[:user_id])
		@complaint = Complaint.find(params[:id])
	end

	def edit
	end

	def update
		@complaint = Complaint.find(params[:id])
		@complaint.status = "resolved"
		if @complaint.update(status: "resolved")
			redirect_to admins_path
		else
			@complaint.errors.full_messages
		end
	end

	def destroy
		@complaint = Complaint.find(params[:id])
		@complaint.destroy
		redirect_to admins_path
	end

	private
	def com_params
		params.require(:complaint).permit(:status)
	end
end
