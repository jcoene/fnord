require "spec_helper"

describe Fnord do

  let :f do
    Fnord.new host: "localhost", port: 1337
  end

  before do
    Fnord.class_eval do
      public :send_data
    end
  end

  context "instantiation" do
    it "takes parameters" do
      f = Fnord.new host: "1.2.3.4"
      f.host.should eql "1.2.3.4"
    end

    it "takes a block" do
      f = Fnord.new do |f|
        f.host = "1.2.3.4"
      end
      f.host.should eql "1.2.3.4"
    end

    it "establishes a socket" do
      f = Fnord.new
      f.socket.should be_an_instance_of(UDPSocket)
    end
  end

  context "event" do
    context "sends the proper message" do
      it "given only a type" do
        f.should_receive(:send_data).with('{"_type":"dogs_hugged"}')
        f.event "dogs_hugged"
      end

      it "given a type and single argument" do
        f.should_receive(:send_data).with('{"_type":"dogs_hugged","dog_type":"frenchie"}')
        f.event "dogs_hugged", dog_type: "frenchie"
      end

      it "given a type and complex arguments" do
        f.should_receive(:send_data).with('{"_type":"dogs_rescued","dog_type":"pitty","dog_age":9,"fun_factor":0.82}')
        f.event "dogs_rescued", dog_type: "pitty", dog_age: 9, "fun_factor" => 0.82
      end

      it "given a type and complex arguments and a namespace" do
        f.should_receive(:send_data).with('{"_type":"dogs_rescued","_namespace":"dogpound","dog_type":"pitty","dog_age":9,"fun_factor":0.82}')
        f.namespace = "dogpound"
        f.event "dogs_rescued", dog_type: "pitty", dog_age: 9, "fun_factor" => 0.82
      end
    end
  end

  context "time" do
    it "times the given block and sends an event with it attached" do
      f.should_receive(:event) do |e,o|
        o[:name].should eql "Alfie"
        o[:time].should be_an_instance_of(Fixnum)
        o[:time].should be > 0
      end
      f.time "dog_walked", name: "Alfie" do
        10000.times { n = 5 ** 100 / 100 ** 100 }
      end
    end
  end

  context "sending data" do
    it "actually sends data" do
      server = UDPSocket.new
      server.bind "localhost", 11111
      f = Fnord.new host: "localhost", port: 11111
      f.event "unicorns_per_hour"
      data, peer = server.recvfrom(128)
      data.should eql '{"_type":"unicorns_per_hour"}'
    end
  end
end
