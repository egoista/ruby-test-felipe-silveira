require 'rails_helper'

describe Webmotors::Gateway do
  let(:webmotors_id) { 1 }

  context 'when ask for makers' do
    before(:each) do
      stub_request(:post, Webmotors::Gateway::MAKERS_URL).
        to_return(:status => 200, :body => makers_response_body)
    end
    it 'should give a array of makers' do
      makers = described_class.new.makers

      expect(makers).to all(be_a(Maker))
    end
  end

  context 'when ask for models' do
    before(:each) do
      stub_request(:post, Webmotors::Gateway::MODELS_URL).
        with(:body => {marca: webmotors_id.to_s}).
        to_return(:status => 200, :body => models_response_body)
    end
    it 'should give a array of models' do
      maker = double('Maker', webmotors_id: webmotors_id, id: 1)
      models = described_class.new.models(maker)

      expect(models).to all(be_a(Model))
    end
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
      }
    ].to_json
  end
end
