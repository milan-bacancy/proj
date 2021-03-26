require 'rails_helper'

RSpec.describe "Complaints", type: :request do
  let(:user) { create(:user) }
  let(:complaint) { create(:complaint) }

  before do
    login_as (user)
    user.role = 'user'
  end

  describe 'GET #new' do
    it 'New Complaint' do
      get '/complaints/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    context 'Get Complaint List' do
      it 'Get index' do
        get '/complaints'
        expect(response).to render_template :index
      end
    end
  end

  describe 'POST Complaint#create' do
    context 'with valid params' do
      let(:complaint) do
        post '/complaints', params: {
          complaint: attributes_for(:complaint)
        }
      end
      it { expect { complaint }.to change(Complaint, :count).by(1) }
    end

    context 'with invalid params' do
      context 'having invalid complaint' do
        let(:complaint) do
          post '/complaints', params: {
            :complaint => { :title => '', :desc => '', :status => '' }
          }
        end
        it { expect { complaint }.not_to change(Complaint, :count) }
      end
    end
  end

  describe 'GET complaints#edit' do
    it 'renders the edit page for task' do
      complaint.user = user
      complaint.save
      get "/complaints/#{complaint.id}/edit", params: { id: complaint.id, complaint: attributes_for(:complaint) }
      expect(response).to render_template :edit
    end
  end

  describe 'PUT Complaint#update' do
    let(:new_attributes) do
      attributes_for(:complaint)
    end

    let(:invalid_attributes) do
      attributes_for(:complaint, complaint_id: nil)
    end

    context 'with valid params' do
      it 'updates the complaint' do
        complaint.user = user
        complaint.save
        put "/complaints/#{complaint.id}", params: { id: complaint.id, complaint: new_attributes }
        expect(complaint.reload)
      end

      it 'redirects to the show page' do
        complaint.user = user
        complaint.save
        put "/complaints/#{complaint.id}", params: { id: complaint.id, complaint: new_attributes }
        expect(response).to redirect_to complaint_path
      end
    end

    context 'with invalid params' do
      before do
        complaint.user = user
        complaint.save
        put "/complaints/#{complaint.id}", params: { id: complaint.id, complaint: invalid_attributes }
      end

      it 'updates the complaint' do
        complaint.reload
        expect(complaint.user_id).not_to eq nil
      end

      it 'renders the show page' do
        expect(response).to redirect_to complaint_path
      end
    end
  end

  describe 'Delete Complaint#destroy' do
    context 'with valid params' do
      let(:delete_complaint) do
        complaint.user = user
        complaint.save
        delete "/complaints/#{complaint.id}", params: { id: complaint.id }
      end

      it { expect { delete_complaint }.to change(Complaint, :count).by(0) }
    end

    context 'with invalid valid params' do
      let(:delete_complaint) do
        complaint.user = user
        complaint.save
        delete "/complaints/#{complaint.id}", params: { id: '' }
      end

      it { expect { delete_complaint }.not_to change(Complaint, :count) }
    end
  end

end
