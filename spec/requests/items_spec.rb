require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }

  describe 'GET /todos/:todo_id/items' do

    before { get "/todos/#{todo_id}/items" }

    context 'when todo exists' do
      it 'returns items' do
        expect(json).not_to be_empty
        expect(json.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end      
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:todo_id/items/:item_id' do

    before { get "/todos/#{todo_id}/items/#{id}" }
    
    context 'when todo item exists' do
      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo item does not exist' do
      
      let(:id) { 0 }
      
      it 'returns the status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'does not return an item' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: "TODO APP", done: false } }
    
    context 'when request is valid' do

      before { post "/todos/#{todo_id}/items", params: valid_attributes }

      # it 'returns the created item' do
      #   expect(json.size).to eq(1)
      # end

      it 'returns the status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do

      before { post "/todos/#{todo_id}/items", params: {} }

      it 'does not create the item' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end

      it 'returns the status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: "Foobar" } }

    before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes }

    context 'when an item exists' do

      it 'returns the status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the request invalid' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'delete /todos/:todo_id/items/:id' do

    before { delete "/todos/#{todo_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
