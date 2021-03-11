class AdminsController < ApplicationController
	def index
		@users = User.all
		@complaints = Complaint.all
	end

	def show
		# @user = User.find(params[:user_id])
		@complaint = Complaint.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
