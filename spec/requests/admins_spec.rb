require 'rails_helper'

RSpec.describe "Admins", type: :request do
  let(:user) { create(:user) }
  let(:complaint) { create(:complaint) }

  before do
    login_as(user)
    user.role = 'admin'
  end
  
  describe "GET /index" do
    context 'Get Complaint List' do
      it 'Get index' do
        get '/admins'
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET /show' do
    context 'Show Complaint' do
      it 'Get show' do
        get "/admins/#{complaint.id}"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PUT Complaint#update' do
    before do
      if complaint.status == 'ongoing'
        @arg = 'resolved'
      else
        @arg = 'ongoing'
      end
    end

    let(:invalid_attributes) do
      attributes_for(:complaint, user_id: nil)
    end

    context 'with valid params' do
      it 'updates the complaint' do
        complaint.user = user
        complaint.save
        put "/admins/#{user.id}", params: { id: user.id, status: @arg }
        expect(complaint.reload)
      end

      it 'redirects to the index page' do
        complaint.user = user
        complaint.save
        put "/admins/#{user.id}", params: { id: user.id, status: @arg }
        expect(response).to redirect_to admins_path
      end
    end

    context 'with invalid params' do
      before do
        complaint.user = user
        complaint.save
        put "/admins/#{user.id}", params: { id: user.id, complaint: invalid_attributes }
      end

      it 'updates the complaint' do
        complaint.reload
        expect(complaint.user_id).not_to eq nil
      end

      it 'renders the index page' do
        expect(response).to redirect_to admins_path
      end
    end
  end

  describe 'Delete Complaint#destroy' do
    context 'with valid params' do
      let(:delete_complaint) do
        complaint.user = user
        complaint.save
        delete "/admins/#{user.id}", params: { id: user.id }
      end

      it { expect { delete_complaint }.to change(Complaint, :count).by(0) }
    end

    context 'with invalid valid params' do
      let(:delete_complaint) do
        complaint.user = user
        complaint.save
        delete "/admins/#{user.id}", params: { id: '' }
      end

      it { expect { delete_complaint }.not_to change(Complaint, :count) }
    end
  end

end
