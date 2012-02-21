require "socket"
require "json"

class Fnord
  attr_accessor :host, :port, :namespace, :socket

  def initialize(attrs={})
    self.socket = UDPSocket.new
    attrs.each {|k,v| send("#{k}=", v)}
    yield self if block_given?
  end

  def event(type, options={})
    options = {_namespace: namespace}.merge(options) if namespace
    packet = { _type: type }.merge(options)
    send_data packet.to_json
  end

  def time(type, options={}, &block)
    start = Time.now
    result = yield
    event type, options.merge({time: ((Time.now-start)*1000).round})
    result
  end

  private

  def send_data(json)
    socket.send "#{json}\n", 0, host, port
  end

end
