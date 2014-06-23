require 'spec_helper'

describe Ptilinopus do
  context "set api key" do
    before do
      @api_key = "test_key"
    end

    after do
      Ptilinopus::API.api_key = nil
    end

    it "in constructor" do
      @ptilinopus = Ptilinopus::API.new(@api_key)
      expect(@ptilinopus.api_key).to eq(@api_key)
    end

    it "set api" do
      Ptilinopus::API.api_key = @api_key
      @ptilinopus = Ptilinopus::API.new
      expect(@ptilinopus.api_key).to eq(@api_key)
    end
  end

  context "call" do
    before do
      @ptilinopus = Ptilinopus::API.new("test_api")
      @method = "api_method"
    end

    it "get method" do
      register_method(:get, @method)
      expect(@ptilinopus.call(:get, @method)).to eq({}.to_s)
    end
    
    it "post method" do
      register_method(:post, @method)
      expect(@ptilinopus.call(:post, @method)).to eq({}.to_s)
    end

    context "raise error" do
      it "if api key is no specified" do
        @ptilinopus.api_key = nil
        expect {@ptilinopus.call(:get, @method)}.to raise_error(StandardError)
      end

      it "if server return HTTP400" do
        register_method(:get, @method, {}, ["400", "Bad Request"])
        expect {@ptilinopus.call(:get, @method)}.to raise_error(Ptilinopus::MailerliteInvalidMethodError)
      end
      
      it "if server return HTTP401" do
        register_method(:get, @method, {}, ["401", "Unauthorized"])
        expect {@ptilinopus.call(:get, @method)}.to raise_error(Ptilinopus::MailerliteInvalidApiKeyError)
      end

      it "if server return HTTP404" do
        register_method(:get, @method, {}, ["404", "Not found"])
        expect {@ptilinopus.call(:get, @method)}.to raise_error(Ptilinopus::MailerliteBadRequestItemError)
      end
    end
  end

  private

  def register_method(type, method, body = {}, status = ["200", "OK"])
    FakeWeb.register_uri(type, URI.join(Ptilinopus::API.base_uri, Ptilinopus::API::API_PATH, method), body: body.to_json, status: status)
  end
end
