require 'rails_helper'

RSpec.describe ModelsController do
  fixtures :models
  fixtures :makers

  describe 'GET #index' do
    let(:webmotors_id) { 1 }

    context 'when pass no webmotors_id param' do
      it 'responds with parameter missing exception' do
        expect { get :index }.to raise_error ActionController::ParameterMissing
      end
    end

    context 'when no new model from the webservice' do

      before(:each) do
        stub_request(:post, 'http://www.webmotors.com.br/carro/modelos').
          with(:body => {marca: webmotors_id.to_s}).
          to_return(:status => 200, :body => no_new_models_response_body)
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :index, webmotors_maker_id: webmotors_id

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders the index template' do
        get :index, webmotors_maker_id: webmotors_id

        expect(response).to render_template('index')
      end

      it 'loads the previous models into @models' do
        maker = Maker.where(webmotors_id: webmotors_id)[0]
        models = maker.models.to_a

        get :index, webmotors_maker_id: webmotors_id

        expect(assigns(:models)).to match_array(models)
      end
    end

    context 'when have new models from the webservice' do

      before(:each) do
        stub_request(:post, 'http://www.webmotors.com.br/carro/modelos').
          with(:body => {marca: webmotors_id.to_s}).
          to_return(:status => 200, :body => new_models_response_body)
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :index, webmotors_maker_id: webmotors_id

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders the index template' do
        get :index, webmotors_maker_id: webmotors_id

        expect(response).to render_template('index')
      end

      it 'loads the new models into @models' do
        maker = Maker.where(webmotors_id: webmotors_id)[0]
        models = maker.models.to_a

        get :index, webmotors_maker_id: webmotors_id

        expect(assigns(:models).any? { |model| model.name == 'NewModel'} ).to be_truthy
        expect(assigns(:models).size).to be > models.size
      end
    end
  end

  def no_new_models_response_body
    [
      {
        Id:1,
        Nome:'Model1',
        Count:0,
        NomeAmigavel:''
      },{
        Id:2,
        Nome:'Model2',
        Count:0,
        NomeAmigavel:''
      }
    ].to_json
  end

  def new_models_response_body
    [
      {
        Id:1,
        Nome:'Model1',
        Count:0,
        NomeAmigavel:''
      },{
        Id:2,
        Nome:'Model2',
        Count:0,
        NomeAmigavel:''
      },{
        Id:3,
        Nome:'NewModel',
        Count:0,
        NomeAmigavel:''
      }
    ].to_json
  end
end
