describe "gateway" do
  context "/_health" do
    context "get" do
      result = Client.get "http://localhost:81/_health"
      it "return 200" do
        expect(result.code).to eq(200)
      end
      it "return OK" do
        expect(result.body).to eq("OK")
      end
    end
  end
  context "/path1" do
    context "get" do
      result = Client.get "http://localhost:81/path1"
      it "return 200" do
        expect(result.code).to eq(200)
      end
      it "proxy to service2" do
        expect(result.body).to eq("https://service2.myapi.com/v1/path1")
      end
      it "response header does not contain nginx version" do
        expect(result.headers[:server]).to eq("nginx")
      end
    end
    context "/some_id" do
      context "get" do
        result = Client.get "http://localhost:81/path1/some_id"
        it "return 200" do
          expect(result.code).to eq(200)
        end
        it "proxy to service1" do
          expect(result.body).to eq("https://service1.myapi.com/v1/path1/some_id")
        end
        it "response header does not contain nginx version" do
          expect(result.headers[:server]).to eq("nginx")
        end
      end
    end
  end
  context "/path2" do
    context "get" do
      result = Client.get "http://localhost:81/path2"
      it "return 404" do
        expect(result.code).to eq(404)
      end
      it "response header does not contain nginx version" do
        expect(result.headers[:server]).to eq("nginx")
      end
    end
    context "/some_id" do
      result = Client.get "http://localhost:81/path2/some_id"
      it "return 200" do
        expect(result.code).to eq(200)
      end
      it "proxy to service3" do
        expect(result.body).to eq("https://service3.myapi.com/v1/path2/some_id")
      end
      it "response header does not contain nginx version" do
        expect(result.headers[:server]).to eq("nginx")
      end
    end
  end
end
