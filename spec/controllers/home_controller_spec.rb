require 'rails_helper'

RSpec.describe HomeController do
  fixtures :models
  fixtures :makers

  describe 'GET #index' do
    context 'when no new maker from the webservice' do

      before(:each) do
        stub_request(:post, Webmotors::Gateway::MAKERS_URL).
          to_return(:status => 200, :body => no_new_makers_response_body)
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :index

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders the index template' do
        get :index

        expect(response).to render_template('index')
      end

      it 'loads the previous makers into @makers' do
        makers = Maker.all.to_a

        get :index

        expect(assigns(:makers)).to match_array(makers)
      end
    end

    context 'when have new makers from the webservice' do

      before(:each) do
        stub_request(:post, Webmotors::Gateway::MAKERS_URL).
          to_return(:status => 200, :body => new_makers_response_body)
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :index

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders the index template' do
        get :index

        expect(response).to render_template('index')
      end

      it 'loads the new makers into @makers' do
        makers = Maker.all.to_a

        get :index

        expect(assigns(:makers).any? { |maker| maker.name == 'NewMaker'} ).to be_truthy
        expect(assigns(:makers).size).to be > makers.size
      end
    end
  end

  def no_new_makers_response_body
    [
      {
        Id:1,
        Nome:'Maker1',
        Count:0,
        IsPrincipal:false,
        Selected:false,
        NomeAmigavel:''
      },{
        Id:2,
        Nome:'Maker2',
        Count:0,
        IsPrincipal:false,
        Selected:false,
        NomeAmigavel:''
      }
    ].to_json
  end

  def new_makers_response_body
    [
      {
        Id:1,
        Nome:'Maker1',
        Count:0,
        IsPrincipal:false,
        Selected:false,
        NomeAmigavel:''
      },{
        Id:2,
        Nome:'Maker2',
        Count:0,
        IsPrincipal:false,
        Selected:false,
        NomeAmigavel:''
      },{
        Id:3,
        Nome:'NewMaker',
        Count:0,
        IsPrincipal:false,
        Selected:false,
        NomeAmigavel:''
      }
    ].to_json
  end
end
