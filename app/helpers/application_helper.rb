module ApplicationHelper
  require 'net/http'

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def api_request path, params
      params = {} unless params.is_a? Hash
      host = 'http://api.stackexchange.com'
      version = '2.2'
      anon_params = {site: 'stackoverflow'}.update params
      param_lst = []
      anon_params.each_pair{|k,v| param_lst << "#{k}=#{v}"}
      param_str = param_lst.join('&')
      link = "#{host}/#{version}/#{path}?#{param_str}"
      begin
        response = Net::HTTP.get(URI.parse(link))
        result = JSON.load response
      rescue Exception=>e
        puts puts "#{e.inspect}\n#{e.backtrace}"
        return
      end
      result
    end

    def load_users nickname
      api_request "users", pagesize:100, inname:nickname
    end

    def load_tags account_id
      api_request "users/#{account_id}/tags", pagesize:5
    end

    def load_questions tag_title
      api_request "questions", tagged:tag_title, pagesize:10
    end
  end

end
