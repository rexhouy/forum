require 'erb'
require 'yaml'
require "digest"

module Config
        begin
                UPLOADS = YAML.load((ERB.new File.new("#{Rails.root}/config/uploads.yml").read).result)[Rails.env]
                SMS = YAML.load((ERB.new File.new("#{Rails.root}/config/sms.yml").read).result)[Rails.env]
                CHAT = YAML.load((ERB.new File.new("#{Rails.root}/config/chat.yml").read).result)[Rails.env]
                PAYMENT = YAML.load((ERB.new File.new("#{Rails.root}/config/payment.yml").read).result)
        rescue
        end
end
