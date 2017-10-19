describe "gateway" do
  context "_health" do
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
      end
    end
  end
end
