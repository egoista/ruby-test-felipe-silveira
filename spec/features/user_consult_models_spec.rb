require 'rails_helper'

feature 'User look for models' do
  fixtures :models
  fixtures :makers

  before(:each) do
    stub_request(:post, 'http://www.webmotors.com.br/carro/marcas').
      to_return(:status => 200, :body => makers_response_body)
    stub_request(:post, 'http://www.webmotors.com.br/carro/modelos').
      with(:body => {marca:'1'}).
      to_return(:status => 200, :body => models_response_body)
  end

  scenario 'they select a maker and see the models' do
    visit '/'

    select 'Maker1', from: 'webmotors_maker_id'
    click_button 'Buscar modelos'

    expect(page).to have_text('Model1')
    expect(page).to have_text('Model2')
    expect(page).to_not have_text('Model3')
    expect(page).to have_text('Model4')
  end

  def makers_response_body
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
        Nome:'Maker3',
        Count:0,
        IsPrincipal:false,
        Selected:false,
        NomeAmigavel:''
      }
    ].to_json
  end

  def models_response_body
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
        Nome:'Model4',
        Count:0,
        NomeAmigavel:''
      }
    ].to_json
  end
end