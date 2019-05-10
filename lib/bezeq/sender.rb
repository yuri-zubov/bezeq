require 'active_support/configurable'
require 'nokogiri'

module Bezeq
  class Sender
    def initialize(options = {})
      @to = options[:to]
      @from = options[:from] || Bezeq.configuration.from

      @message = options[:message]
      @dlr_url = options[:dlr_url] || Bezeq.configuration.dlr_url
      @override_source = options[:override_source] || Bezeq.configuration.override_source
      @msg_id = options[:msg_id]
    end

    def base_url
      Bezeq.configuration.end_point || 'https://vast.bezeq.co.il/imsc/interfaces/largeaccount/la3.sms'.freeze
    end

    def deliver
      request
    end

    private

    def data
      <<~XML
        <?xml version="1.0" encoding="utf-8" ?>
        <request>
          <head>
            <auth>
              <account>#{Bezeq.configuration.account}</account>
              <user>#{Bezeq.configuration.user}</user>
              <pass>#{Bezeq.configuration.pass}</pass>
            </auth>
            <action>sendsms</action>
          </head>
          <body>
            <addr>
              <from>#{@from}</from>
              <to>
                  <cli>#{@to}</cli>
              </to>
            </addr>
            <data>
              <msgtype>text</msgtype>
              <text>#{@message}</text>
            </data>
            <billing>
              <port>0</port>
            </billing>
            <optional>
              <dlr_url>#{@dlr_url}</dlr_url>
              <msg_id>#{@msg_id}</msg_id>
              <override_source>#{@override_source}</override_source>
            </optional>
          </body>
        </request>
      XML
    end

    def get_reason(doc)
      doc.at_xpath('//reason').content
    end

    def get_status(doc)
      doc.at_xpath('//status').content
    end

    def request
      headers = {
        'Content-Type' => 'text/xml; charset=utf-8'
      }
      url = URI(base_url)
      responce = Net::HTTP.post(url, data, headers)
      doc = Nokogiri::XML(responce.body)
      raise(get_reason(doc)) if get_status(doc) != 'SUCCESS'
      responce.body
    end
  end
end
